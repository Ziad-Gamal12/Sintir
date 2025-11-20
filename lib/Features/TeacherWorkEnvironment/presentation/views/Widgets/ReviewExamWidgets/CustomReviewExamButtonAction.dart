import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateExamReviewRequirmentsEntity.dart';
import 'package:sintir/constant.dart';

class CustomReviewExamButtonAction extends StatelessWidget {
  const CustomReviewExamButtonAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NavigateExamReviewRequirmentsEntity navigatesqlreviewrequirmentsentity =
        context.read<NavigateExamReviewRequirmentsEntity>();
    return BlocBuilder<TestItemCubit, TestItemState>(
      builder: (context, state) {
        return Custom_Loading_Widget(
          isLoading: state is AddTestItemLoading ||
              state is QuestionsImagesUploadedingLoading,
          child: Custombutton(
              text: "اضافة امتحان",
              color: KMainColor,
              textColor: Colors.white,
              onPressed: () async {
                await Future.wait([
                  context.read<TestItemCubit>().uploadTestQuestionsImages(
                        test:
                            navigatesqlreviewrequirmentsentity.coursetestentity,
                      ),
                  context
                      .read<TestItemCubit>()
                      .uploadTestQuestionsSolutionsImages(
                        test:
                            navigatesqlreviewrequirmentsentity.coursetestentity,
                      ),
                ]);
              }),
        );
      },
    );
  }
}
