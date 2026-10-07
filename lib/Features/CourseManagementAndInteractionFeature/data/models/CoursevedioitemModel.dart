import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';

class CourseVideoItemModel {
  final String title, vedioUrl;
  final int durationTime;
  final String id;
  final String? type,
      videoProvider,
      muxUploadId,
      muxAssetId,
      muxPlaybackId,
      status;
  final List<String> availableQualities;
  CourseVideoItemModel({
    required this.title,
    required this.vedioUrl,
    required this.durationTime,
    required this.id,
    this.type = "Video",
    this.videoProvider,
    this.muxUploadId,
    this.muxAssetId,
    this.muxPlaybackId,
    this.status,
    this.availableQualities = const [],
  });
  factory CourseVideoItemModel.fromJson(Map<String, dynamic> json) =>
      CourseVideoItemModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        vedioUrl: json['vedioUrl'] ?? '',
        durationTime: (json['durationTime'] as num?)?.toInt() ??
            (json['durationSeconds'] as num?)?.toInt() ??
            0,
        type: json['type'],
        videoProvider: json['videoProvider'],
        muxUploadId: json['muxUploadId'],
        muxAssetId: json['muxAssetId'],
        muxPlaybackId: json['muxPlaybackId'],
        status: json['status'],
        availableQualities:
            List<String>.from(json['availableQualities'] ?? const []),
      );
  factory CourseVideoItemModel.fromEntity(CourseVideoItemEntity entity) =>
      CourseVideoItemModel(
        id: entity.id,
        title: entity.title,
        vedioUrl: entity.vedioUrl,
        durationTime: entity.durationTime,
        type: entity.type,
        videoProvider: entity.videoProvider,
        muxUploadId: entity.muxUploadId,
        muxAssetId: entity.muxAssetId,
        muxPlaybackId: entity.muxPlaybackId,
        status: entity.status,
        availableQualities: entity.availableQualities,
      );
  CourseVideoItemEntity toEntity() => CourseVideoItemEntity(
        id: id,
        title: title,
        vedioUrl: vedioUrl,
        durationTime: durationTime,
        type: type,
        videoProvider: videoProvider,
        muxUploadId: muxUploadId,
        muxAssetId: muxAssetId,
        muxPlaybackId: muxPlaybackId,
        status: status,
        availableQualities: availableQualities,
      );
  Map<String, dynamic> toJson() => {
        'title': title,
        'vedioUrl': vedioUrl,
        'durationTime': durationTime,
        'type': type,
        'id': id,
      };
}
