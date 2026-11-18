import 'dart:io';

import 'package:path/path.dart';
import 'package:sintir/Core/services/EdgeFunctionsService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/SupabaseBuckets.dart';
import 'package:sintir/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageUploadSlot {
  const StorageUploadSlot({
    required this.bucket,
    required this.path,
    required this.token,
    required this.contentType,
    this.publicUrl,
  });

  factory StorageUploadSlot.fromJson(Map<String, dynamic> json) {
    final bucket = json['bucket'];
    final path = json['path'];
    final token = json['token'];
    if (bucket is! String || path is! String || token is! String) {
      throw const EdgeFunctionException(
        'invalid_response',
        'The server returned an invalid response.',
        200,
      );
    }
    final contentType = json['contentType'];
    final publicUrl = json['publicUrl'];
    return StorageUploadSlot(
      bucket: bucket,
      path: path,
      token: token,
      contentType: contentType is String
          ? contentType
          : 'application/octet-stream',
      publicUrl: publicUrl is String && publicUrl.isNotEmpty
          ? publicUrl
          : null,
    );
  }

  final String bucket;
  final String path;
  final String token;
  final String contentType;
  final String? publicUrl;
}

class SupabaseStorageServices implements StorageService {
  SupabaseStorageServices({EdgeFunctionsService? edgeFunctions})
      : _edgeFunctions = edgeFunctions;

  final EdgeFunctionsService? _edgeFunctions;

  EdgeFunctionsService get _functions =>
      _edgeFunctions ?? EdgeFunctionsService();

  static SupabaseClient get _client => Supabase.instance.client;

  static Future<void> initSupabase() async {
    await Supabase.initialize(url: supaBaseUrl, anonKey: supaAnonKey);
  }

  static String uploadPurposeFor(String? bucketname) {
    if (bucketname == SupabaseBuckets.Users.name) return 'avatar';
    if (bucketname == SupabaseBuckets.Support.name) return 'support';
    return 'course_media';
  }

  @override
  Future<String> uploadFile({required File file, String? bucketname}) async {
    final slot = await _requestSlot(
      file: file,
      purpose: uploadPurposeFor(bucketname),
    );
    await _upload(slot, file);
    return slot.publicUrl ?? slot.path;
  }

  @override
  Future<String> uploadCourseFile({
    required File file,
    required String courseId,
  }) async {
    final slot = await _requestSlot(
      file: file,
      purpose: 'course_file',
      courseId: courseId,
    );
    await _upload(slot, file);
    return slot.path;
  }

  Future<StorageUploadSlot> _requestSlot({
    required File file,
    required String purpose,
    String? courseId,
  }) async {
    final response = await _functions.invoke('create-upload-url', {
      'purpose': purpose,
      'fileName': basename(file.path),
      'sizeBytes': await file.length(),
      if (courseId != null) 'courseId': courseId,
    });
    return StorageUploadSlot.fromJson(response);
  }

  Future<void> _upload(StorageUploadSlot slot, File file) {
    return _client.storage.from(slot.bucket).uploadToSignedUrl(
          slot.path,
          slot.token,
          file,
          FileOptions(contentType: slot.contentType),
        );
  }

  String getFileUrl({required String bucketname, required String filepath}) {
    return _client.storage.from(bucketname).getPublicUrl(filepath);
  }

  @override
  Future<void> deleteFile({required String url}) async {}
}
