import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/constant.dart';

class SubscribtionViewBodyActionButton extends StatelessWidget {
  const SubscribtionViewBodyActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseSubscribtionsCubit, CourseSubscribtionsState,
        bool>(
      selector: (state) => state is PayWithWalletLoading,
      builder: (context, state) => Custom_Loading_Widget(
        isLoading: state,
        child: Custombutton(
          text: "اشترك الان",
          color: KSecondaryColor,
          textColor: Colors.white,
          onPressed: () {
            context
                .read<CourseSubscribtionsCubit>()
                .payWithWallet(userEntity: getUserData());
          },
        ),
      ),
    );
  }
}
