import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/manager/TestOverViewCubit/TestOverViewCubit.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/courseTestView.dart';
import 'package:sintir/locale_keys.dart';

class CourseTestOverViewBodyJoinExamButton extends StatefulWidget {
  const CourseTestOverViewBodyJoinExamButton({
    super.key,
    required this.courseExamViewNavigationsRequirmentsEntity,
  });

  final CourseExamViewNavigationsRequirmentsEntity
      courseExamViewNavigationsRequirmentsEntity;

  @override
  State<CourseTestOverViewBodyJoinExamButton> createState() =>
      _CourseTestOverViewBodyJoinExamButtonState();
}

class _CourseTestOverViewBodyJoinExamButtonState
    extends State<CourseTestOverViewBodyJoinExamButton> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TestOverViewCubit>().hasReachedMaxAttempts(
            courseId:
                widget.courseExamViewNavigationsRequirmentsEntity.course.id,
            sectionId:
                widget.courseExamViewNavigationsRequirmentsEntity.sectionId,
            test: widget.courseExamViewNavigationsRequirmentsEntity.test,
            userId: getUserData().uid,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestOverViewCubit, TestOverViewState>(
      buildWhen: (previous, current) {
        return current is HasReachedMaxAttemptsLoading ||
            current is HasReachedMaxAttemptsFailure ||
            current is HasReachedMaxAttemptsSuccess;
      },
      builder: (context, state) {
        if (state is HasReachedMaxAttemptsLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        } else if (state is HasReachedMaxAttemptsFailure) {
          return Center(
            child: Text(
              state.errMessage,
              textAlign: TextAlign.center,
              style:
                  AppTextStyles(context).semiBold12.copyWith(color: Colors.red),
            ),
          );
        } else if (state is HasReachedMaxAttemptsSuccess &&
            state.hasReachedMaxAttempts == true) {
          return Center(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                LocaleKeys.maxAttemptsReached,
                textAlign: TextAlign.center,
                style: AppTextStyles(context)
                    .semiBold12
                    .copyWith(color: Colors.red),
              ),
            ),
          );
        }
        return Custombutton(
            text: LocaleKeys.startTest,
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () {
              GoRouter.of(context).pushReplacement(
                Coursetestview.routename,
                extra: widget.courseExamViewNavigationsRequirmentsEntity,
              );
            });
      },
    );
  }
}
