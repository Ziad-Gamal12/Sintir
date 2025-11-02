import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/CustomAddCourseVideoSectionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/VideoItemStateHandler.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/VideoPreviewWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/VideoTitleInputField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/CourseSectionStateHandler.dart';
import 'package:sintir/constant.dart';

class Addcoursesectionvedioviewbody extends StatefulWidget {
  const Addcoursesectionvedioviewbody({super.key});

  @override
  State<Addcoursesectionvedioviewbody> createState() =>
      _AddcoursesectionvedioviewbodyState();
}

class _AddcoursesectionvedioviewbodyState
    extends State<Addcoursesectionvedioviewbody> {
  late final CourseVideoItemEntity courseVideoItemEntity;

  @override
  void initState() {
    super.initState();
    courseVideoItemEntity = CourseVideoItemEntity(
      title: "",
      vedioUrl: "",
      durationTime: 0,
      id: "${DateTime.now().toIso8601String()}-Video",
    );
  }

  @override
  Widget build(BuildContext context) {
    final requires = context.read<OptionNavigationRequirementsEntity>();
    return MultiBlocListener(
      listeners: [
        BlocListener<VideoItemCubit, VideoItemState>(
          listener: (context, state) =>
              VideoItemStateHandler(context, courseVideoItemEntity)
                  .handle(state),
        ),
        BlocListener<CourseSectionsCubit, CourseSectionsState>(
          listener: (context, state) =>
              CourseSectionStateHandler(context, requires.courseEntity)
                  .handle(state),
        ),
      ],
      child: BlocBuilder<VideoItemCubit, VideoItemState>(
        builder: (context, state) => Stack(
          children: [
            _buildForm(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: Variables.AddCourseSectionVideoItemFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding,
          vertical: KVerticalPadding,
        ),
        child: Column(
          children: [
            VideoTitleInputField(courseVedioItemEntity: courseVideoItemEntity),
            const SizedBox(height: 10),
            if (courseVideoItemEntity.file != null)
              VideoPreviewWidget(
                videoFile: courseVideoItemEntity.file!,
                coursevedioitementity: courseVideoItemEntity,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 32,
      child: CustomAddCourseVideoSectionButton(
        coursevedioitementity: courseVideoItemEntity,
      ),
    );
  }
}
