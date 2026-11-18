// ignore_for_file: file_names
import 'dart:io';

abstract class StorageService {
  Future<String> uploadFile({required File file, String? bucketname});
  Future<String> uploadCourseFile({
    required File file,
    required String courseId,
  });
  Future<void> deleteFile({required String url});
}
