import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Core/services/StorageService.dart';

class VideoItemRepoImpli implements VideoItemRepo {
  final StorageService storageService;

  VideoItemRepoImpli({required this.storageService});
  @override
  Future<Either<Failure, String>> uploadVideo(
      {required CourseVideoItemEntity coursevedioitementity}) async {
    try {
      String url =
          await storageService.uploadFile(file: coursevedioitementity.file!);

      return right(url);
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
