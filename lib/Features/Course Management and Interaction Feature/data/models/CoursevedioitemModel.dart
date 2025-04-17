import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';

class Coursevedioitemmodel {
  final String title, vedioUrl;
  final int durationTime;
  final String id;
  String? type;

  Coursevedioitemmodel(
      {required this.title,
      required this.vedioUrl,
      required this.durationTime,
      required this.id,
      this.type = "Video"});
  factory Coursevedioitemmodel.fromJson(Map<String, dynamic> json) =>
      Coursevedioitemmodel(
        id: json['id'],
        title: json['title'],
        vedioUrl: json['vedioUrl'],
        durationTime: json['durationTime'],
        type: json['type'],
      );
  factory Coursevedioitemmodel.fromEntity(Coursevedioitementity entity) =>
      Coursevedioitemmodel(
          id: entity.id,
          title: entity.title,
          vedioUrl: entity.vedioUrl,
          durationTime: entity.durationTime,
          type: entity.type);
  Coursevedioitementity toEntity() => Coursevedioitementity(
      id: id,
      title: title,
      vedioUrl: vedioUrl,
      durationTime: durationTime,
      type: type);
  Map<String, dynamic> toJson() => {
        'title': title,
        'vedioUrl': vedioUrl,
        'durationTime': durationTime,
        'type': type,
        'id': id
      };
}
