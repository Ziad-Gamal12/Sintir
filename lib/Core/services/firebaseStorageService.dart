// ignore_for_file: camel_case_types, depend_on_referenced_packages, file_names, await_only_futures

import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';

class firebasestorageservice {
  final storage = FirebaseStorage.instance;
  final Pickerassetsservice pickerassetsservice;
  firebasestorageservice({required this.pickerassetsservice});

  Future<String> uploadFile({required ImageSource source}) async {
    try {
      File file = await pickerassetsservice.uploadAsset(source: source);
      String filePath = basename(file.path);
      var ref = storage.ref(filePath);
      String url =
          await ref.putFile(file).then((p0) => p0.ref.getDownloadURL());
      return url;
    } catch (e) {
      log("Exception from firebasestorageservice.uploadFile in catch With Firebase Exception: ${e.toString()}");
      throw CustomException(message: "خطأ في تحميل الملف");
    }
  }
}
