import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CoursevedioitemModel.dart';

void main() {
  test('reads legacy Supabase video records', () {
    final model = CourseVideoItemModel.fromJson({
      'id': 'legacy-1',
      'title': 'Lesson',
      'vedioUrl': 'https://legacy.example/video.m3u8',
      'durationTime': 42,
      'type': 'Vedio',
    });
    expect(model.videoProvider, isNull);
    expect(model.vedioUrl, startsWith('https://legacy.example/'));
    expect(model.toEntity().vedioUrl, model.vedioUrl);
  });

  test('reads Mux lifecycle metadata without requiring a playback URL', () {
    final model = CourseVideoItemModel.fromJson({
      'id': 'mux-1',
      'title': 'Processing lesson',
      'vedioUrl': '',
      'durationSeconds': 0,
      'type': 'Vedio',
      'videoProvider': 'mux',
      'muxUploadId': 'upload-1',
      'status': 'processing',
      'availableQualities': <String>[],
    });
    expect(model.videoProvider, 'mux');
    expect(model.status, 'processing');
    expect(model.muxUploadId, 'upload-1');
    expect(model.toEntity().vedioUrl, isEmpty);
    expect(model.toJson().keys, isNot(contains('muxPlaybackId')));
  });
}
