import 'package:sintir/Features/TeacherProfile/domain/entities/customSocialLinksItemEntity.dart';

class Customsociallinksitemmodel {
  final String imageURL;
  final String text;

  Customsociallinksitemmodel({required this.imageURL, required this.text});
  factory Customsociallinksitemmodel.fromEnity(
          Customsociallinksitementity entity) =>
      Customsociallinksitemmodel(imageURL: entity.imageURL, text: entity.text);
  factory Customsociallinksitemmodel.fromJson(Map<String, dynamic> json) =>
      Customsociallinksitemmodel(
          imageURL: json["imageURL"], text: json["text"]);
  Map<String, dynamic> toJson() => {"imageURL": imageURL, "text": text};
  Customsociallinksitementity toEntity() =>
      Customsociallinksitementity(imageURL: imageURL, text: text);
}
