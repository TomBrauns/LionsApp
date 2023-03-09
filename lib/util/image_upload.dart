import 'dart:io' show File;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload {
  static Future<XFile?> selectImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);
    return file;
  }

  static Future<String?> uploadImage(
      XFile file, String dir, String subDir, String fileName) async {
    final Reference referenceRoot = FirebaseStorage.instance.ref();
    final Reference referenceDirImages = referenceRoot.child(dir).child(subDir);
    final Reference referenceImageToUpload = referenceDirImages.child(fileName);

    if (kIsWeb) {
      // Web
      final bytes = await file.readAsBytes();
      await referenceImageToUpload.putData(bytes);
    } else {
      // Android & iOS
      await referenceImageToUpload.putFile(File(file.path));
    }
    return referenceImageToUpload.getDownloadURL();
  }
}
