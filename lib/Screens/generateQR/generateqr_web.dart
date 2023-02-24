import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';

class QrCode_Web extends StatefulWidget {
  final String link;
  final String documentId;

  QrCode_Web({required this.link, required this.documentId});

  @override
  _QrCode_WebState createState() => _QrCode_WebState();
}

class _QrCode_WebState extends State<QrCode_Web> {
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
                  final bytes = await _captureQrCode();
                  final blob = html.Blob([bytes]);
                  final url = html.Url.createObjectUrlFromBlob(blob);
                  final anchor = html.document.createElement('a') as html.AnchorElement
                    ..href = url
                    ..download = 'qr_code.png'
                    ..style.display = 'none';
                  html.document.body?.children.add(anchor);
                  anchor.click();
                  html.document.body?.children.remove(anchor);
                  html.Url.revokeObjectUrl(url);
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
}
