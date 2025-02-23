// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CoursedetailsviewOptionitemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CustomCourseDetailsBodyCourse_Info.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CustomCourseDetails_OptionIte.dart';
import 'package:sintir/constant.dart';

class CoursedetailviewBody extends StatefulWidget {
  const CoursedetailviewBody({super.key, required this.courseEntity});
  final CourseEntity courseEntity;

  @override
  State<CoursedetailviewBody> createState() => _CoursedetailviewBodyState();
}

class _CoursedetailviewBodyState extends State<CoursedetailviewBody> {
  int courrentIndex = 0;
  List<Widget> options = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomCourseDetailsBodyCourse_Info(
                courseEntity: widget.courseEntity),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: CoursedetailsviewOptionitemEntity.toList()
                .asMap()
                .entries
                .map((e) {
              return Expanded(
                child: InkWell(
                  onTap: () {
                    courrentIndex = e.key;
                    setState(() {});
                  },
                  child: CustomcoursedetailsOptionitem(
                    item: e.value,
                    isSelected: e.key == courrentIndex,
                  ),
                ),
              );
            }).toList(),
          )),
          SliverFillRemaining(
            hasScrollBody: true,
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return options[index];
                }),
          )
        ],
      ),
    );
  }
}
