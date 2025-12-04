// ignore_for_file: file_names

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/locale_keys.dart';

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
        return left(ServerFailure(message: LocaleKeys.imageNotFound));
      }
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
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
        return left(ServerFailure(message: LocaleKeys.imageNotFound));
      }
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
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
        return left(ServerFailure(message: LocaleKeys.videoNotFound));
      }
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, File>> pickFile() async {
    try {
      File? file = await pickerassetsservice.getFile();
      if (file != null) {
        return right(file);
      } else {
        return left(ServerFailure(message: LocaleKeys.fileNotFound));
      }
    } catch (e) {
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
        return left(ServerFailure(message: LocaleKeys.videoNotFound));
      }
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}
