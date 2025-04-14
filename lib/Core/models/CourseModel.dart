// ignore_for_file: file_names

import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/models/contentCreaterModel.dart';

class Coursemodel {
  final String id, posterUrl, title, description, language, state;
  final int price;
  final String postedDate;
  final Map contentcreaterentity;

  Coursemodel({
    required this.id,
    required this.posterUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.language,
    required this.state,
    required this.postedDate,
    required this.contentcreaterentity,
  });

  factory Coursemodel.fromEntity({required CourseEntity courseEntity}) {
    return Coursemodel(
      id: courseEntity.id,
      posterUrl: courseEntity.posterUrl ?? "",
      title: courseEntity.title,
      description: courseEntity.description,
      price: courseEntity.price,
      language: courseEntity.language,
      state: courseEntity.state,
      postedDate: courseEntity.postedDate,
      contentcreaterentity: courseEntity.contentcreaterentity != null
          ? Contentcreatermodel.fromEntity(
                  entity: courseEntity.contentcreaterentity!)
              .toJson()
          : {},
    );
  }
  factory Coursemodel.fromJson(Map<String, dynamic> json) {
    return Coursemodel(
      id: json['id'],
      posterUrl: json['posterUrl'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      language: json['language'],
      state: json['state'],
      postedDate: json['postedDate'],
      contentcreaterentity: json['contentcreaterentity'],
    );
  }
  CourseEntity toEntity() {
    return CourseEntity(
      id: id,
      posterUrl: posterUrl,
      title: title,
      description: description,
      price: price,
      language: language,
      state: state,
      postedDate: postedDate,
      contentcreaterentity:
          Contentcreatermodel.fromJson(data: contentcreaterentity).toEntity(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'posterUrl': posterUrl,
      'title': title,
      'description': description,
      'contentcreaterentity': contentcreaterentity,
      'price': price,
      'language': language,
      'state': state,
      'postedDate': postedDate,
    };
  }
}
