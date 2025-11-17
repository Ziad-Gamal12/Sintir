import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';

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
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: getDispalyedWidget(),
      ),
    );
  }

  Widget getDispalyedWidget() {
    if (widget.coursetestquestionentity.imageFile != null) {
      return Image.file(
        widget.coursetestquestionentity.imageFile!,
        fit: BoxFit.cover,
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.assetsIconsAddImageIcon,
            height: 25,
            width: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "الصورة المصغرة للسؤال",
            style:
                AppTextStyles(context).semiBold12.copyWith(color: Colors.black),
          )
        ],
      );
    }
  }
}
