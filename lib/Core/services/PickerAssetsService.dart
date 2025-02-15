// ignore_for_file: file_names

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Pickerassetsservice {
  final ImagePicker picker = ImagePicker();
  Future<File?> getImage({required ImageSource source}) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return null;
    File file = File(pickedFile.path);
    return file;
  }

  Future<File?> getVideo({required ImageSource source}) async {
    final pickedFile = await picker.pickVideo(
      source: source,
    );
    if (pickedFile == null) return null;
    File file = File(pickedFile.path);
    return file;
  }
}
