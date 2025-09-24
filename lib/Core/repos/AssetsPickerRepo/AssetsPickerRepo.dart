// ignore_for_file: file_names

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class Assetspickerrepo {
  Future<Either<Failure, File>> pickImageFromGallery();
  Future<Either<Failure, File>> pickImageFromCamera();
  Future<Either<Failure, File>> pickVideoFromCamera();
  Future<Either<Failure, File>> pickVideoFromGallery();
  Future<Either<Failure, File>> pickFile();
}
