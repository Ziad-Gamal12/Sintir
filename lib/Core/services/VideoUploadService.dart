import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/VideoUploadSessionEntity.dart';
import 'package:sintir/constant.dart';

class VideoUploadService {
  VideoUploadService({Dio? dio, FirebaseAuth? auth})
      : _dio = dio ?? Dio(),
        _auth = auth ?? FirebaseAuth.instance;
  final Dio _dio;
  final FirebaseAuth _auth;
  static const _chunkSize = 5 * 1024 * 1024;
  static const _maxRetries = 3;
  final Map<String, int> _confirmedOffsets = {};

  Future<Map<String, String>> _headers() async {
    final token = await _auth.currentUser?.getIdToken();
    if (token == null || token.isEmpty) {
      throw StateError('Sign in is required.');
    }
    return {
      'Authorization': 'Bearer $token',
      'apikey': supaAnonKey,
      'Content-Type': 'application/json'
    };
  }

  Future<Map<String, dynamic>> _invoke(
      String endpoint, Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '$supaBaseUrl/functions/v1/$endpoint',
      data: body,
      options: Options(
          headers: await _headers(),
          validateStatus: (code) => code != null && code < 600),
    );
    if (response.statusCode == null ||
        response.statusCode! >= 400 ||
        response.data?['ok'] != true) {
      final err = response.data?['error'];
      throw StateError(err is Map
          ? (err['message'] ?? 'Video request failed.').toString()
          : 'Video request failed.');
    }
    return response.data!;
  }

  Future<VideoUploadSessionEntity> createUpload(
      {required String courseId,
      required String sectionId,
      required String title,
      required String description,
      required File file}) async {
    final data = await _invoke('create-video-upload', {
      'courseId': courseId.trim(),
      'sectionId': sectionId.trim(),
      'title': title,
      'description': description,
      'fileName': path.basename(file.path),
      'mimeType': _mimeType(file.path),
      'fileSizeBytes': await file.length(),
    });
    return VideoUploadSessionEntity(
        videoId: data['videoId'] as String,
        uploadId: data['uploadId'] as String,
        uploadUrl: data['uploadUrl'] as String);
  }

  Future<void> uploadFile(
      {required File file,
      required VideoUploadSessionEntity session,
      required void Function(double progress, int uploadedBytes, int totalBytes)
          onProgress,
      required CancelToken cancelToken}) async {
    final length = await file.length();
    var offset = _confirmedOffsets[session.uploadId] ?? 0;
    while (offset < length) {
      final start = offset;
      final end = (start + _chunkSize).clamp(0, length);
      var sent = false;
      for (var attempt = 0; attempt < _maxRetries && !sent; attempt++) {
        if (cancelToken.isCancelled) {
          throw DioException(
              type: DioExceptionType.cancel,
              requestOptions: RequestOptions(path: ""));
        }
        try {
          final response = await _dio.put<Object?>(session.uploadUrl,
              data: file.openRead(start, end),
              cancelToken: cancelToken,
              options: Options(
                  contentType: _mimeType(file.path),
                  headers: {
                    HttpHeaders.contentLengthHeader: end - start,
                    'Content-Range': 'bytes $start-${end - 1}/$length',
                  },
                  validateStatus: (code) =>
                      code == 200 || code == 201 || code == 308,
                  receiveTimeout: const Duration(minutes: 2),
                  sendTimeout: const Duration(minutes: 5)),
              onSendProgress: (sentBytes, total) {
            final uploaded = (start + sentBytes).clamp(0, length);
            onProgress(uploaded / length, uploaded, length);
          });
          offset = response.statusCode == 200 || response.statusCode == 201
              ? length
              : end;
          sent = true;
          _confirmedOffsets[session.uploadId] = offset;
          onProgress(offset / length, offset, length);
          if (offset == length) _confirmedOffsets.remove(session.uploadId);
        } on DioException catch (e) {
          if (CancelToken.isCancel(e) || attempt + 1 == _maxRetries) rethrow;
          await Future<void>.delayed(
              Duration(milliseconds: 500 * (attempt + 1)));
        }
      }
    }
  }

  Future<Map<String, dynamic>> resume(
          {required String courseId,
          required String sectionId,
          required String videoId}) =>
      _invoke('resume-video-upload', {
        'courseId': courseId.trim(),
        'sectionId': sectionId.trim(),
        'videoId': videoId
      });
  Future<void> cancel(
          {required String courseId,
          required String sectionId,
          required String videoId}) async =>
      _invoke('cancel-video-upload', {
        'courseId': courseId.trim(),
        'sectionId': sectionId.trim(),
        'videoId': videoId
      });
  Future<Map<String, dynamic>> playback(
          {required String courseId,
          required String sectionId,
          required String videoId,
          String quality = 'Auto'}) =>
      _invoke('get-video-playback-token', {
        'courseId': courseId.trim(),
        'sectionId': sectionId.trim(),
        'videoId': videoId,
        'quality': quality
      });

  String _mimeType(String filePath) {
    switch (path.extension(filePath).toLowerCase()) {
      case '.mov':
        return 'video/quicktime';
      case '.webm':
        return 'video/webm';
      case '.mkv':
        return 'video/x-matroska';
      case '.avi':
        return 'video/x-msvideo';
      case '.m4v':
        return 'video/x-m4v';
      default:
        return 'video/mp4';
    }
  }
}
