import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionSuccessViewSubscribeButton.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseIntroductionSuccessViewSubscribeButtonBuilder
    extends StatefulWidget {
  const CourseIntroductionSuccessViewSubscribeButtonBuilder({
    super.key,
    required this.isSubscribed,
  });

  final bool isSubscribed;

  @override
  State<CourseIntroductionSuccessViewSubscribeButtonBuilder> createState() =>
      _CourseIntroductionSuccessViewSubscribeButtonBuilderState();
}

class _CourseIntroductionSuccessViewSubscribeButtonBuilderState
    extends State<CourseIntroductionSuccessViewSubscribeButtonBuilder> {
  @override
  Widget build(BuildContext context) {
    CourseEntity course = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .course;
    return BlocConsumer<CourseSubscribtionsCubit, CourseSubscribtionsState>(
      listener: (context, state) {
        if (state is SubscibeingToCourseSuccess) {
          setState(() {
            context
                .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
                .isSubscribed = true;
          });
        }
      },
      builder: (context, state) {
        if (state is SubscibeingToCourseLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: KSecondaryColor,
          ));
        } else if (state is SubscibeingToCourseFailure) {
          return Center(
              child: Text(
            state.errMessge,
            style: AppTextStyles(context).regular14.copyWith(color: Colors.red),
          ));
        } else if (state is SubscibeingToCourseSuccess) {
          return Center(
              child: Text(
            LocaleKeys.successSubscribe,
            style:
                AppTextStyles(context).regular14.copyWith(color: Colors.green),
          ));
        }
        return CourseIntroductionSuccessViewSubscribeButton(
            widget: widget, course: course);
      },
    );
  }
}
