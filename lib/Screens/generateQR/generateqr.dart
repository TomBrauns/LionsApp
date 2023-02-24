import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class QrCodeWithImage extends StatefulWidget {
  final String link;
  final String documentId;

  QrCodeWithImage({required this.link, required this.documentId});

  @override
  _QrCodeWithImageState createState() => _QrCodeWithImageState();
}

class _QrCodeWithImageState extends State<QrCodeWithImage> {
  final GlobalKey _repaintBoundaryKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String data = "${widget.link}?interneId=${widget.documentId}";
    Uint8List qrCodeData = Uint8List.fromList(utf8.encode(data));

    const String imagePath = 'assets/projects/Umweltschutz.png';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('QR Code with Image'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: RepaintBoundary(
            key: _repaintBoundaryKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImage(
                  data: data,
                  version: QrVersions.auto,
                  size: 200.0,
                  gapless: false,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  embeddedImage: AssetImage(imagePath),
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: const Size(60, 60),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                 _handleDownloadButtonPressed();
                },
                child: Text('Download'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List?> _captureQrCode() async {
    try {
      final pixelRatio = MediaQuery.of(context).devicePixelRatio;
      final boundary = _repaintBoundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: pixelRatio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print('Error capturing QR code: $e');
      return null;
    }
  }

  Future<String?> _saveQrCode(Uint8List bytes) async {
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/qr_code.png');
      await file.writeAsBytes(bytes);
      return file.path;
    } catch (e) {
      print('Error saving QR code: $e');
      return null;
    }
  }

  void _handleDownloadButtonPressed() async{
    final bytes = await _captureQrCode();
    if(bytes != null){
      final filePath = await _saveQrCode(bytes);
      if(filePath != null){
        Share.shareFiles([filePath], text: 'QR Code');
      }
    }
  }

}
