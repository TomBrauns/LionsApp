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
import 'package:share/share.dart';

import 'package:universal_html/html.dart' as html;

import '../../Widgets/appbar.dart';
import '../../Widgets/textSize.dart';

class QrCodeEventList extends StatefulWidget {
  final String link;

  QrCodeEventList({required this.link});

  @override
  _QrCodeEventListState createState() => _QrCodeEventListState();
}

class _QrCodeEventListState extends State<QrCodeEventList> {
  final GlobalKey _repaintBoundaryKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String data = "${widget.link}";
    Uint8List qrCodeData = Uint8List.fromList(utf8.encode(data));


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'QR Code'),
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
                  if(kIsWeb){
                    _handleWebDownloadButtonPressed();
                  }else{
                    _handleDownloadButtonPressed();
                  }
                },
                child: Text('Download',style: CustomTextSize.medium),
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

  Future<void> _handleWebDownloadButtonPressed() async {
    final bytes = await _captureQrCode();
    if (bytes != null) {
      final blob = html.Blob([bytes]);
      final dataUrl = html.Url.createObjectUrlFromBlob(blob);
      final anchorElement = html.document.createElement('a') as html.AnchorElement
        ..href = dataUrl
        ..download = 'qr_code.png';


      html.document.body!.append(anchorElement);
      anchorElement.click();

      html.document.body!.querySelector('a')?.remove();
      html.Url.revokeObjectUrl(dataUrl);
    }
  }
}
