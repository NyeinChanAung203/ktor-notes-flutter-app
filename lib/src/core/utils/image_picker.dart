import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage({ImageSource source = ImageSource.gallery}) async {
  try {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: source);
    if (imageFile != null) {
      return File(imageFile.path);
    }
    return null;
  } catch (e) {
    debugPrint('cannot pick image $e');
    return null;
  }
}
