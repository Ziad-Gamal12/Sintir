// ignore_for_file: file_names

import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';

class Assetspickerrepoimpli implements Assetspickerrepo {
  final Pickerassetsservice pickerassetsservice;

  Assetspickerrepoimpli({required this.pickerassetsservice});

  @override
  Future<Either<Failure, File>> pickImageFromGallery() async {
    try {
      File? file =
          await pickerassetsservice.getImage(source: ImageSource.gallery);
      if (file != null) {
        return right(file);
      } else {
        return left(ServerFailure(message: "الصورة غير موجودة"));
      }
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, File>> pickImageFromCamera() async {
    try {
      File? file =
          await pickerassetsservice.getImage(source: ImageSource.camera);
      if (file != null) {
        return right(file);
      } else {
        return left(ServerFailure(message: "الصورة غير موجودة"));
      }
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, File>> pickVideoFromCamera() async {
    try {
      File? file =
          await pickerassetsservice.getVideo(source: ImageSource.camera);
      if (file != null) {
        return right(file);
      } else {
        return left(ServerFailure(message: "الفيديو غير موجودة"));
      }
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, File>> pickFile() async {
    try {
      File? file = await pickerassetsservice.getFile();
      if (file != null) {
        return right(file);
      } else {
        return left(ServerFailure(message: "الملف غير موجودة"));
      }
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, File>> pickVideoFromGallery() async {
    try {
      File? file =
          await pickerassetsservice.getVideo(source: ImageSource.gallery);
      if (file != null) {
        return right(file);
      } else {
        return left(ServerFailure(message: "الفيديو غير موجودة"));
      }
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
