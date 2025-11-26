import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/File-Item-Repo/FileItemRepo.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/locale_keys.dart';

class FileItemRepoImpli implements FileItemRepo {
  final StorageService storageService;

  FileItemRepoImpli({required this.storageService});

  @override
  Future<Either<Failure, String>> uploadFile(
      {required CourseFileEntity coursefileEntity}) async {
    try {
      String url =
          await storageService.uploadFile(file: coursefileEntity.file!);

      return right(url);
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}
