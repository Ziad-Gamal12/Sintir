import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';

class Coursevideoitemmodel {
  final String title, vedioUrl;
  final int durationTime;
  String? type;
  String? preffixImage;
  Coursevideoitemmodel(
      {required this.title,
      required this.vedioUrl,
      required this.durationTime,
      this.type = "Vedio",
      this.preffixImage = Assets.assetsImagesVedioIcon});
  factory Coursevideoitemmodel.fromJson(Map<String, dynamic> json) {
    return Coursevideoitemmodel(
      title: json['title'],
      vedioUrl: json['vedioUrl'],
      durationTime: json['durationTime'],
      type: json['type'],
      preffixImage: json['preffixImage'],
    );
  }
  factory Coursevideoitemmodel.fromEntity(Coursevedioitementity entity) {
    return Coursevideoitemmodel(
      title: entity.title,
      vedioUrl: entity.vedioUrl,
      durationTime: entity.durationTime,
      type: entity.type,
      preffixImage: entity.preffixImage,
    );
  }
  Coursevedioitementity toEntity() {
    return Coursevedioitementity(
      title: title,
      vedioUrl: vedioUrl,
      durationTime: durationTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'vedioUrl': vedioUrl,
        'durationTime': durationTime,
        'type': type,
        'preffixImage': preffixImage,
      };
}
