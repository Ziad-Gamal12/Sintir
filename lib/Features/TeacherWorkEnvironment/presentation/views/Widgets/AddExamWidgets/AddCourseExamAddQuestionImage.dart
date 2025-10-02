import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/utils/imageAssets.dart';

class AddCourseExamAddQuestionImage extends StatefulWidget {
  const AddCourseExamAddQuestionImage(
      {super.key,
      required this.pickerassetsservice,
      required this.coursetestquestionentity});
  final Pickerassetsservice pickerassetsservice;
  final CourseTestQuestionEntity coursetestquestionentity;
  @override
  State<AddCourseExamAddQuestionImage> createState() =>
      _AddCourseExamAddQuestionImageState();
}

class _AddCourseExamAddQuestionImageState
    extends State<AddCourseExamAddQuestionImage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        File? image = await widget.pickerassetsservice
            .getImage(source: ImageSource.gallery);
        if (context.mounted) {
          widget.coursetestquestionentity.imageFile = image;
          setState(() {});
        }
      },
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 20, left: 27, right: 27, bottom: 29),
        decoration: BoxDecoration(
          color: const Color(0xffF9FAFA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.coursetestquestionentity.imageFile != null
            ? Image.file(
                widget.coursetestquestionentity.imageFile!,
                fit: BoxFit.cover,
              )
            : Image.asset(
                Assets.assetsIconsAddImageIcon,
                height: 50,
                width: 50,
              ),
      ),
    );
  }
}
