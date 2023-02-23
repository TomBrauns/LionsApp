import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';

class QrCodeWithImage extends StatelessWidget {
  final String link;
  final String documentId;

  QrCodeWithImage({required this.link, required this.documentId});

  @override
  Widget build(BuildContext context) {
    // Generate QR code data
    String data = "$link?interneId=$documentId";
    Uint8List qrCodeData = Uint8List.fromList(utf8.encode(data));

    // Define image asset path
    const String imagePath = 'assets/projects/Umweltschutz.png';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('QR Code with Image'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Image.asset(imagePath),
                const SizedBox(height: 32),
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
    );
  }
}