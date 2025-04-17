// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/showSnackBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/CustomAddCourseVideoSectionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/VideoPreviewWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/VideoTitleInputField.dart';
import 'package:sintir/constant.dart';

class Addcoursesectionvedioviewbody extends StatefulWidget {
  const Addcoursesectionvedioviewbody({
    super.key,
  });

  @override
  State<Addcoursesectionvedioviewbody> createState() =>
      _AddcoursesectionvedioviewbodyState();
}

class _AddcoursesectionvedioviewbodyState
    extends State<Addcoursesectionvedioviewbody> {
  Coursevedioitementity coursevedioitementity = Coursevedioitementity(
      title: "",
      vedioUrl: "",
      durationTime: 0,
      id: "${DateTime.now().toIso8601String()}-Video");

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
      listener: (context, state) {
        addCourseSectionVideoBlocListener(state, context);
      },
      builder: (context, state) => Stack(
        children: [
          Form(
            key: Variables.AddCourseSectionVideoItemFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: KHorizontalPadding, vertical: KVerticalPadding),
              child: Column(
                children: [
                  VideoTitleInputField(
                    courseVedioItemEntity: coursevedioitementity,
                  ),
                  const SizedBox(height: 10),
                  coursevedioitementity.file != null
                      ? VideoPreviewWidget(
                          videoFile: coursevedioitementity.file!,
                          coursevedioitementity: coursevedioitementity,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 32,
            child: CustomAddCourseVideoSectionButton(
              coursevedioitementity: coursevedioitementity,
            ),
          )
        ],
      ),
    );
  }

  void addCourseSectionVideoBlocListener(
      CourseSectionsState state, BuildContext context) {
    if (state is VideoUploadedingSuccuss) {
      videoUploadingSuccess(context, state);
    } else if (state is VideoUploadedingFailure) {
      showSnackBar(context, state.errMessage);
    } else if (state is AddCourseSectionSuccess) {
      successdialog(
          context: context,
          SuccessMessage: "تم اضافة الملف بنجاح",
          btnOkOnPress: () {
            context.go(
              Homeview.routeName,
            );
          }).show();
    } else if (state is AddCourseSectionFailure) {
      errordialog(context, state.errMessage).show();
    } else if (state is AddCourseSectionVedioPicked) {
      coursevedioitementity.file = state.videoFile;
    } else if (state is AddCourseSectionVedioUnPicked) {
      showSnackBar(context, "لم يتم اختيار فيديو");
    }
  }

  void videoUploadingSuccess(
      BuildContext context, VideoUploadedingSuccuss state) {
    Variables.AddCourseSectionVideoItemFormKey.currentState!.save();
    Optionnavigationrequirementsentity optionnavigationrequirementsentity =
        context.read<Optionnavigationrequirementsentity>();
    coursevedioitementity.vedioUrl = state.url;
    if (optionnavigationrequirementsentity.isNewSection) {
      context.read<CourseSectionsCubit>().addCourseSection(
          sectionItem: coursevedioitementity,
          courseId: optionnavigationrequirementsentity.courseID,
          section: optionnavigationrequirementsentity.section);
    } else {
      context.read<CourseSectionsCubit>().addSectionItem(
          courseId: optionnavigationrequirementsentity.courseID,
          sectionId: optionnavigationrequirementsentity.section.id,
          sectionItem: coursevedioitementity);
    }
  }
}
