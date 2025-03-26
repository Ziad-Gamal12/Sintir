import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';
import 'package:sintir/constant.dart';

class CustomReviewSQlTestButtonAction extends StatelessWidget {
  const CustomReviewSQlTestButtonAction({
    super.key,
    required this.navigatesqlreviewrequirmentsentity,
  });

  final Navigatesqlreviewrequirmentsentity navigatesqlreviewrequirmentsentity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseSectionCubit, AddCourseSectionState>(
      builder: (context, state) {
        return Custom_Loading_Widget(
          isLoading: state is UpdateCourseSectionsLoading ||
              state is QuestionsImagesUploadedingLoading,
          child: Custombutton(
              text: "اضافة امتحان",
              color: KMainColor,
              textColor: Colors.white,
              onPressed: () {
                context.read<AddCourseSectionCubit>().uploadTestQuestionsImages(
                      test: navigatesqlreviewrequirmentsentity.coursetestentity,
                    );
              }),
        );
      },
    );
  }
}
