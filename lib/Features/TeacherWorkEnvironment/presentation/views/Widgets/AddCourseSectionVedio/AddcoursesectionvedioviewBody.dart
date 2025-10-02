// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
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
  CourseVideoItemEntity coursevedioitementity = CourseVideoItemEntity(
      title: "",
      vedioUrl: "",
      durationTime: 0,
      id: "${DateTime.now().toIso8601String()}-Video");

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<VideoItemCubit, VideoItemState>(
              listener: (context, state) {
            videoItemListener(state, context);
          }),
          BlocListener<CourseSectionsCubit, CourseSectionsState>(
              listener: (context, state) {
            courseSectionListener(state, context);
          })
        ],
        child: BlocBuilder<VideoItemCubit, VideoItemState>(
            builder: (context, state) {
          return Stack(
            children: [
              Form(
                key: Variables.AddCourseSectionVideoItemFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: KHorizontalPadding,
                      vertical: KVerticalPadding),
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
          );
        }));
  }

  void courseSectionListener(CourseSectionsState state, BuildContext context) {
    if (state is AddCourseSectionFailure) {
      errordialog(context, state.errMessage).show();
    } else if (state is AddCourseSectionSuccess) {
      successdialog(
          context: context,
          SuccessMessage: "تم اضافة الملف بنجاح",
          btnOkOnPress: () {
            context.go(
              Homeview.routeName,
            );
          }).show();
    }
  }

  void videoItemListener(VideoItemState state, BuildContext context) {
    if (state is AddVideoItemFailure) {
      errordialog(context, state.errMessage).show();
    } else if (state is AddVideoItemSuccess) {
      successdialog(
          context: context,
          SuccessMessage: "تم اضافة الملف بنجاح",
          btnOkOnPress: () {
            context.go(
              Homeview.routeName,
            );
          }).show();
    } else if (state is PickVideoFileSuccess) {
      coursevedioitementity.file = state.file;
    } else if (state is PickVideoFileFailure) {
      ShowSnackBar(
          context: context,
          child: Text("لم يتم اختيار الملف",
              style: AppTextStyles(context)
                  .regular14
                  .copyWith(color: Colors.white)),
          backgroundColor: Colors.red);
    } else if (state is UploadVideoSuccess) {
      videoUploadingSuccess(context, state);
    } else if (state is UploadVideoFailure) {
      ShowSnackBar(
          context: context,
          child: Text(state.errMessage,
              style: AppTextStyles(context)
                  .regular14
                  .copyWith(color: Colors.white)),
          backgroundColor: Colors.red);
    }
  }

  void videoUploadingSuccess(BuildContext context, UploadVideoSuccess state) {
    Variables.AddCourseSectionVideoItemFormKey.currentState!.save();
    OptionNavigationRequirementsEntity optionnavigationrequirementsentity =
        context.read<OptionNavigationRequirementsEntity>();
    coursevedioitementity.vedioUrl = state.url;
    if (optionnavigationrequirementsentity.isNewSection) {
      context.read<CourseSectionsCubit>().addCourseSection(
          sectionItem: coursevedioitementity,
          courseId: optionnavigationrequirementsentity.courseID,
          section: optionnavigationrequirementsentity.section);
    } else {
      context.read<VideoItemCubit>().addVideoItem(
          courseId: optionnavigationrequirementsentity.courseID,
          sectionId: optionnavigationrequirementsentity.section.id,
          video: coursevedioitementity);
    }
  }
}
