import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/ReviewTestResultView.dart';

class CourseTestListener extends StatelessWidget {
  const CourseTestListener({
    super.key,
    required this.test,
    required this.stopWatchTimer,
    required this.builder,
    required this.courseId,
  });

  final CourseTestEntity test;
  final dynamic stopWatchTimer;
  final String courseId;
  final Widget Function(BuildContext context, TestItemState state) builder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestItemCubit, TestItemState>(
      listener: (context, state) {
        if (state is JoinToTestItemSuccess) {
          CustomSnackBar.show(
            context,
            message: "تم التسجيل بنجاح",
            type: SnackType.success,
          );
        } else if (state is JoinToTestItemFailure) {
          CustomSnackBar.show(
            context,
            message: state.errMessage,
            type: SnackType.error,
          );
        } else if (state is AddTestResultSuccess) {
          successdialog(
            context: context,
            SuccessMessage: "تم إنهاء الاختبار بنجاح",
            btnOkOnPress: () {
              GoRouter.of(context).pushReplacement(
                Reviewtestresultview.routeName,
                extra: context.read<TestItemCubit>().getTestResults(
                      courseId: courseId,
                      context: context,
                      test: test,
                      user: getUserData(),
                    ),
              );
            },
          ).show();
        } else if (state is AddTestResultFailure) {
          errordialog(context, state.errMessage).show();
        }
      },
      builder: builder,
    );
  }
}
