import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/edit_course_description_field.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/edit_course_poster.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/edit_course_save_button.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/edit_course_title_field.dart';

class EditCourseInfoSection extends StatelessWidget {
  const EditCourseInfoSection({super.key, required this.course});
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              const SizedBox(
                width: 30,
              ),
              Text(
                "تعديل بيانات الدورة",
                style: AppTextStyles.bold20Auto.copyWith(color: Colors.black),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          EditCourseTitleField(
            courseTitle: course.title,
          ),
          const SizedBox(height: 10),
          EditCourseDescriptionField(
            courseDescription: course.description,
          ),
          const SizedBox(height: 20),
          EditCoursePoster(
            coursePosterUrl: course.posterUrl ?? "",
          ),
          const SizedBox(height: 40),
          const EditCourseSaveButton(),
        ],
      ),
    );
  }
}
