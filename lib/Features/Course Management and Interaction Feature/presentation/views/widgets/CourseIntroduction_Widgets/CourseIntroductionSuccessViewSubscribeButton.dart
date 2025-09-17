import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/constant.dart';

class CourseIntroductionSuccessViewSubscribeButton extends StatelessWidget {
  const CourseIntroductionSuccessViewSubscribeButton({
    super.key,
    required this.isSubscribed,
  });

  final bool isSubscribed;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isSubscribed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        height: 80,
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
        child: Custombutton(
            text: "أشترك الأن",
            color: KSecondaryColor,
            textColor: Colors.white,
            onPressed: () {
              context
                  .read<CourseSubscribtionsCubit>()
                  .subscribeToCourse(userEntity: getUserData());
            }),
      ),
    );
  }
}
