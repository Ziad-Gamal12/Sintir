import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Pickerassetsservice {
  final ImagePicker picker = ImagePicker();
  Future<File> getImage({required ImageSource source}) async {
    final pickedFile = await picker.pickImage(source: source);

    File file = File(pickedFile!.path);
    return file;
  }
}
