import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/JoinedByModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';

class Coursevedioitemmodel {
  final String title, vedioUrl;
  final int durationTime;
  final List<Map<String, dynamic>> joinedBy;

  String? type;

  Coursevedioitemmodel(
      {required this.title,
      required this.vedioUrl,
      required this.durationTime,
      required this.joinedBy,
      this.type = "Video"});
  factory Coursevedioitemmodel.fromJson(Map<String, dynamic> json) =>
      Coursevedioitemmodel(
        joinedBy: (json['joinedBy'] as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList(),
        title: json['title'],
        vedioUrl: json['vedioUrl'],
        durationTime: json['durationTime'],
        type: json['type'],
      );
  factory Coursevedioitemmodel.fromEntity(Coursevedioitementity entity) =>
      Coursevedioitemmodel(
          joinedBy: entity.joinedBy
              .map((e) => JoinedbyModel.fromEntity(e).toJson())
              .toList(),
          title: entity.title,
          vedioUrl: entity.vedioUrl,
          durationTime: entity.durationTime,
          type: entity.type);
  Coursevedioitementity toEntity() => Coursevedioitementity(
      joinedBy:
          joinedBy.map((e) => JoinedbyModel.fromJson(e).toEntity()).toList(),
      title: title,
      vedioUrl: vedioUrl,
      durationTime: durationTime,
      type: type);
  Map<String, dynamic> toJson() => {
        'title': title,
        'vedioUrl': vedioUrl,
        'durationTime': durationTime,
        'type': type,
        'joinedBy': joinedBy
      };
}
