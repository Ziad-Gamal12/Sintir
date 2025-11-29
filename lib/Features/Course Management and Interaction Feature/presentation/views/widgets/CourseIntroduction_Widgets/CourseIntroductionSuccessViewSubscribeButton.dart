import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionSuccessViewSubscribeButtonBuilder.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/SubscribtionView.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseIntroductionSuccessViewSubscribeButton extends StatelessWidget {
  const CourseIntroductionSuccessViewSubscribeButton({
    super.key,
    required this.widget,
    required this.course,
  });

  final CourseIntroductionSuccessViewSubscribeButtonBuilder widget;
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !widget.isSubscribed,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: 16),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 30, offset: Offset(0, -15))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Custombutton(
                  text: LocaleKeys.subscribeNow,
                  color: KSecondaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    GoRouter.of(context).push(SubscribtionView.routeName,
                        extra: context.read<
                            DisplayCourseBottomsheetNavigationRequirmentsEntity>());
                  }),
            ),
            const SizedBox(
              width: 20,
            ),
            Text("${course.price}  ${LocaleKeys.priceEgp}",
                style:
                    AppTextStyles(context).bold20.copyWith(color: Colors.red))
          ],
        ),
      ),
    );
  }
}
