import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/SubscribtionView.dart';
import 'package:sintir/constant.dart';

class CourseIntroductionSuccessViewSubscribeButton extends StatefulWidget {
  const CourseIntroductionSuccessViewSubscribeButton({
    super.key,
    required this.isSubscribed,
  });

  final bool isSubscribed;

  @override
  State<CourseIntroductionSuccessViewSubscribeButton> createState() =>
      _CourseIntroductionSuccessViewSubscribeButtonState();
}

class _CourseIntroductionSuccessViewSubscribeButtonState
    extends State<CourseIntroductionSuccessViewSubscribeButton> {
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
            "تم الأشتراك بالكورس بنجاح",
            style:
                AppTextStyles(context).regular14.copyWith(color: Colors.green),
          ));
        }
        return Visibility(
          visible: !widget.isSubscribed,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: KHorizontalPadding, vertical: 20),
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 4,
                    offset: const Offset(0, -15))
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Custombutton(
                      text: "أشترك الأن",
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
                Text("${course.price} جنيه",
                    style: AppTextStyles(context)
                        .semiBold20
                        .copyWith(color: Colors.red))
              ],
            ),
          ),
        );
      },
    );
  }
}
