// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class VideoItemRepo {
  Future<Either<Failure, String>> uploadVideo({
    required Coursevedioitementity coursevedioitementity,
  });
}
