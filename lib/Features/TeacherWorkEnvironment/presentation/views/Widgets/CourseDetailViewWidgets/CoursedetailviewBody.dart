// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/CustomCourseDetailsBodyCourse_Info.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsRowOptionsSectionWidgets/CourseDetailsViewRowOptions.dart';
import 'package:sintir/constant.dart';

class CourseDetailViewBody extends StatefulWidget {
  const CourseDetailViewBody({super.key, required this.courseEntity});
  final CourseEntity courseEntity;

  @override
  State<CourseDetailViewBody> createState() => _CourseDetailViewBodyState();
}

class _CourseDetailViewBodyState extends State<CourseDetailViewBody> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: CustomCourseDetailsBodyCourseInfo(
              courseEntity: widget.courseEntity,
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                'التقاصيل',
                style: AppTextStyles(context).bold20,
              ),
              const SizedBox(height: 20),
            ],
          )),
          CourseDetailsViewRowOptions(
            course: widget.courseEntity,
          ),
          SliverToBoxAdapter(
            child: Custombutton(
                text: "حذف",
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () {}),
          )
        ],
      ),
    );
  }
}
