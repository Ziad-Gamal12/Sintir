import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/constant.dart';

class PhotoInputBlocBuilder extends StatefulWidget {
  const PhotoInputBlocBuilder({
    super.key,
    required this.state,
  });
  final TeacherSignUpState state;

  @override
  State<PhotoInputBlocBuilder> createState() => _PhotoInputBlocBuilderState();
}

class _PhotoInputBlocBuilderState extends State<PhotoInputBlocBuilder> {
  bool isCanUpload = true;

  @override
  Widget build(BuildContext context) {
    if (widget.state is UploadTeacherProfilePictureSuccess) {
      return Container(
          alignment: Alignment.center,
          height: 40,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green, width: 1)),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              const Customsizedbox(width: 10, height: 0),
              Text(
                "تم تحميل الصورة بنجاح",
                style: AppTextStyles.bold13.copyWith(color: Colors.green),
              ),
            ],
          ));
    } else if (widget.state is UploadTeacherProfilePictureLoading) {
      return Center(
        child: LinearProgressIndicator(
          minHeight: 10,
          borderRadius: BorderRadius.circular(2),
          color: KMainColor,
        ),
      );
    } else if (widget.state is UploadTeacherProfilePictureFailure) {
      return InkWell(
        onTap: () {
          UploadPicture(context);
        },
        child: Container(
            alignment: Alignment.center,
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red, width: 1)),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                const Customsizedbox(width: 10, height: 0),
                Text(
                  "فشل تحميل الصورة",
                  style: AppTextStyles.bold13.copyWith(color: Colors.red),
                ),
              ],
            )),
      );
    } else {
      return InkWell(
        onTap: () {
          UploadPicture(context);
        },
        child: Container(
            alignment: Alignment.center,
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1)),
            child: Row(
              children: [
                const Icon(
                  Icons.upload,
                  color: Colors.grey,
                ),
                const Customsizedbox(width: 10, height: 0),
                Text(
                  "رجاء قم بتحميل الصورة",
                  style: AppTextStyles.bold13.copyWith(color: Colors.grey),
                ),
              ],
            )),
      );
    }
  }

  UploadPicture(BuildContext context) async {
    if (isCanUpload) {
      context
          .read<TeacherSignUpCubit>()
          .uploadTeacherProfilePicture(source: ImageSource.gallery);
      isCanUpload = false;

      Future.delayed(const Duration(seconds: 20), () {
        isCanUpload = true;
        setState(() {});
      });
    } else {
      ShowSnackBar(
          context: context,
          child: const Text("يجب عليك الانتظار قبل تحميل الصورة"),
          backgroundColor: Colors.red);
    }
  }
}
