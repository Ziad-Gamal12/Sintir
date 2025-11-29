import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class VideoTitleInputField extends StatelessWidget {
  const VideoTitleInputField({super.key, required this.courseVedioItemEntity});
  final CourseVideoItemEntity courseVedioItemEntity;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: LocaleKeys.enterVideoNameHere,
      obscureText: false,
      textInputType: TextInputType.text,
      onSaved: (value) {
        courseVedioItemEntity.title = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return LocaleKeys.enterVideoName;
        }
        return null;
      },
    );
  }
}
