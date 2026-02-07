import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/SupabaseBuckets.dart';
import 'package:sintir/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageServices implements StorageService {
  final String _defaultBucket = SupabaseBuckets.DefaultBucket.toString();

  static SupabaseClient get _client => Supabase.instance.client;

  static Future<void> initSupabase() async {
    await Supabase.initialize(
      url: supaBaseUrl,
      anonKey: supaAnonKey,
    );
  }

  @override
  Future<String> uploadFile({required File file, String? bucketname}) async {
    final bucket = bucketname ?? _defaultBucket;
    log("Uploading to bucket: $bucket");
    final fileName =
        "${DateTime.now().millisecondsSinceEpoch}_${basename(file.path)}";

    try {
      await _client.storage.from(bucket).upload(fileName, file);

      return getFileUrl(bucketname: bucket, filepath: fileName);
    } on StorageException catch (e) {
      log("Supabase Storage Error: ${e.message}");
      rethrow;
    } catch (e) {
      log("Unexpected Error: $e");
      rethrow;
    }
  }

  String getFileUrl({required String bucketname, required String filepath}) {
    return _client.storage.from(bucketname).getPublicUrl(filepath);
  }

  @override
  Future<void> deleteFile({required String url}) async {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      final bucketIndex = segments.indexOf('public') + 1;

      final bucketName = segments[bucketIndex];
      final filePath = segments.sublist(bucketIndex + 1).join('/');

      await _client.storage.from(bucketName).remove([filePath]);
    } catch (e) {
      log("Delete Error: $e");
    }
  }
}
