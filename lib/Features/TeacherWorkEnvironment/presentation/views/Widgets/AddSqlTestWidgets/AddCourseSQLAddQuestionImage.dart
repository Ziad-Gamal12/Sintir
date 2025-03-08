import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';

class Addcoursesqladdquestionimage extends StatefulWidget {
  const Addcoursesqladdquestionimage(
      {super.key, required this.pickerassetsservice});
  final Pickerassetsservice pickerassetsservice;

  @override
  State<Addcoursesqladdquestionimage> createState() =>
      _AddcoursesqladdquestionimageState();
}

class _AddcoursesqladdquestionimageState
    extends State<Addcoursesqladdquestionimage> {
  @override
  Widget build(BuildContext context) {
    Coursetestquestionentity question =
        context.read<Coursetestquestionentity>();
    return InkWell(
      onTap: () async {
        File? image = await widget.pickerassetsservice
            .getImage(source: ImageSource.gallery);
        if (context.mounted) {
          question.imageFile = image;
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
        child: question.imageFile != null
            ? Image.file(
                question.imageFile!,
                fit: BoxFit.cover,
              )
            : Image.asset(
                Assets.assetsImagesAddImageIcon,
                height: 50,
                width: 50,
              ),
      ),
    );
  }
}
