import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseIntroductionView.dart';
import 'package:sintir/constant.dart';

class CourseBottomSheetUnSubscribedActionButtons extends StatelessWidget {
  const CourseBottomSheetUnSubscribedActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSubscribtionsCubit, CourseSubscribtionsState>(
      builder: (context, state) {
        return Column(
          children: [
            Custombutton(
                text: "استكشاف المحتوى",
                color: Colors.white,
                textColor: Colors.black,
                side: const BorderSide(width: 1, color: Colors.black),
                onPressed: () {
                  GoRouter.of(context).push(CourseIntroductionView.routeName,
                      extra: context.read<
                          DisplayCourseBottomsheetNavigationRequirmentsEntity>());
                }),
            const SizedBox(
              height: 10,
            ),
            Custom_Loading_Widget(
              isLoading: state is SubscibeingToCourseLoading ||
                  state is PayWithWalletLoading,
              child: Custombutton(
                  text: "أشترك الأن",
                  color: KSecondaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    context
                        .read<CourseSubscribtionsCubit>()
                        .payWithWallet(userEntity: getUserData());
                  }),
            ),
          ],
        );
      },
    );
  }
}
