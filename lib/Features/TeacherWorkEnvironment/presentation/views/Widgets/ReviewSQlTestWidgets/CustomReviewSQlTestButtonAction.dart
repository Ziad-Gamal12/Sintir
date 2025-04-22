import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/constant.dart';

class CustomReviewSQlTestButtonAction extends StatelessWidget {
  const CustomReviewSQlTestButtonAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Navigatesqlreviewrequirmentsentity navigatesqlreviewrequirmentsentity =
        context.read<Navigatesqlreviewrequirmentsentity>();
    return BlocBuilder<TestItemCubit, TestItemState>(
      builder: (context, state) {
        return Custom_Loading_Widget(
          isLoading: state is AddTestItemLoading ||
              state is QuestionsImagesUploadedingLoading,
          child: Custombutton(
              text: "اضافة امتحان",
              color: KMainColor,
              textColor: Colors.white,
              onPressed: () {
                context.read<TestItemCubit>().uploadTestQuestionsImages(
                      test: navigatesqlreviewrequirmentsentity.coursetestentity,
                    );
              }),
        );
      },
    );
  }
}
