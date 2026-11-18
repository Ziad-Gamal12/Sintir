import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/File-Item-Repo/FileItemRepo.dart';
import 'package:sintir/Core/services/EdgeFunctionsService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/locale_keys.dart';

class FileItemRepoImpli implements FileItemRepo {
  final StorageService storageService;
  final EdgeFunctionsService edgeFunctions;

  FileItemRepoImpli({
    required this.storageService,
    EdgeFunctionsService? edgeFunctions,
  }) : edgeFunctions = edgeFunctions ?? EdgeFunctionsService();

  @override
  Future<Either<Failure, String>> uploadFile({
    required CourseFileEntity coursefileEntity,
    required String courseId,
  }) async {
    try {
      final path = await storageService.uploadCourseFile(
        file: coursefileEntity.file!,
        courseId: courseId,
      );
      return right(path);
    } on EdgeFunctionException catch (e) {
      return left(ServerFailure(message: _failureMessage(e)));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, String>> getFileUrl({
    required String courseId,
    required String sectionId,
    required CourseFileEntity file,
  }) async {
    if (isPublicFileUrl(file.fileUrl)) return right(file.fileUrl);
    try {
      final response = await edgeFunctions.invoke('get-course-file-url', {
        'courseId': courseId,
        'sectionId': sectionId,
        'itemId': file.id,
      });
      final url = response['url'];
      if (url is! String || url.isEmpty) {
        return left(ServerFailure(message: LocaleKeys.fileNotFound));
      }
      return right(url);
    } on EdgeFunctionException catch (e) {
      return left(ServerFailure(message: _failureMessage(e)));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  static bool isPublicFileUrl(String value) {
    final lower = value.toLowerCase();
    return lower.startsWith('https://') || lower.startsWith('http://');
  }

  static String _failureMessage(EdgeFunctionException e) {
    switch (e.code) {
      case 'network_error':
      case 'network_timeout':
        return LocaleKeys.noInternet;
      case 'file_not_found':
        return LocaleKeys.fileNotFound;
      case 'not_subscribed':
      case 'course_unavailable':
      case 'forbidden':
      case 'inactive_user':
        return LocaleKeys.secureContentAccessDenied;
      case 'file_too_large':
      case 'unsupported_file_type':
        return LocaleKeys.secureFileNotAllowed;
      default:
        return LocaleKeys.errorOccurredMessage;
    }
  }
}
