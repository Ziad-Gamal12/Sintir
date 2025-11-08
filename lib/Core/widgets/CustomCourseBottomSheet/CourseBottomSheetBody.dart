// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomContentCreator.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheetBodyCoursePoster.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheetCourseDetails.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CustomCourseBottomSheetActionButtons.dart';
import 'package:sintir/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseBottomSheetBody extends StatefulWidget {
  const CourseBottomSheetBody({
    super.key,
  });

  @override
  State<CourseBottomSheetBody> createState() => _CourseBottomSheetBodyState();
}

class _CourseBottomSheetBodyState extends State<CourseBottomSheetBody> {
  @override
  void initState() {
    if (mounted) {
      context
          .read<CourseSubscribtionsCubit>()
          .checkIfSubscribed(uid: getUserData().uid);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSubscribtionsCubit, CourseSubscribtionsState>(
      listener: (context, state) {
        courseBottomSheetBlocListener(state, context);
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is CheckIfSubscribedLoading,
          child: const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: KHorizontalPadding, vertical: KVerticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CourseBottomSheetBodyCoursePoster(),
                SizedBox(
                  height: 20,
                ),
                CourseBottomSheetCourseDetails(),
                SizedBox(
                  height: 20,
                ),
                CourseBottomContentCreator(),
                SizedBox(
                  height: 20,
                ),
                CustomCourseBottomSheetActionButtons()
              ],
            ),
          ),
        );
      },
    );
  }

  void courseBottomSheetBlocListener(
      CourseSubscribtionsState state, BuildContext context) {
    if (state is SubscibeingToCourseSuccess) {
      successdialog(
          context: context, SuccessMessage: "تم الاشتراك", btnOkOnPress: () {});
    } else if (state is SubscibeingToCourseFailure) {
      errordialog(context, state.errMessge).show();
    } else if (state is CheckIfSubscribedSuccess) {
      context
          .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
          .isSubscribed = state.isSubscribed;
    } else if (state is CheckIfSubscribedFailure) {
      ShowSnackBar(
          context: context,
          child: Text(state.errMessage,
              style: AppTextStyles(context)
                  .regular14
                  .copyWith(color: Colors.white)),
          backgroundColor: Colors.red);
    }
  }
}
