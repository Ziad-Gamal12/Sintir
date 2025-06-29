import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/AddCoursePoster.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_Cubit.dart';

class EditCoursePoster extends StatelessWidget {
  const EditCoursePoster({
    super.key,
    required this.coursePosterUrl,
  });
  final String coursePosterUrl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateCourseCubit, UpdateCourseState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Addcourseposter(
            coursePosterUrl: coursePosterUrl,
            coursePosterImage:
                context.watch<UpdateCourseCubit>().coursePosterImage,
            onTap: () {
              context.read<UpdateCourseCubit>().pickCoursePosterImage();
            },
          ),
        );
      },
    );
  }
}
