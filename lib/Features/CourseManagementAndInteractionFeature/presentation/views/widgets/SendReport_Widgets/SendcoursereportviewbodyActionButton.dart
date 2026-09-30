import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/locale_keys.dart';

class SendcoursereportviewbodyActionButton extends StatelessWidget {
  const SendcoursereportviewbodyActionButton(
      {super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CourseReportsCubit, CourseReportsState>(
          builder: (context, state) => FilledButton(
              onPressed:
                  state is CourseReportsAddReportLoading ? null : onPressed,
              child: state is CourseReportsAddReportLoading
                  ? const CircularProgressIndicator()
                  : Text(LocaleKeys.submitReport)));
}
