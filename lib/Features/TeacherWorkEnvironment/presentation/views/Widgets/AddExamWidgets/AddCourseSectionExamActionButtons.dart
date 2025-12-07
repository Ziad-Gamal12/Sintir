import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class AddCourseSectionExamActionButtons extends StatefulWidget {
  const AddCourseSectionExamActionButtons({
    super.key,
    required this.courseTestEntity,
    required this.currentStep,
    required this.examDetailsFormKey,
    required this.questionsFormKey,
    required this.pageController,
  });
  final CourseTestEntity courseTestEntity;
  final int currentStep;
  final GlobalKey<FormState> examDetailsFormKey;
  final GlobalKey<FormState> questionsFormKey;
  final PageController pageController;

  @override
  State<AddCourseSectionExamActionButtons> createState() =>
      _AddCourseSectionExamActionButtonsState();
}

class _AddCourseSectionExamActionButtonsState
    extends State<AddCourseSectionExamActionButtons> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.pageController.addListener(() {
        if (currentIndex != widget.pageController.page!.toInt()) {
          setState(() {
            currentIndex = widget.pageController.page!.toInt();
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    OptionNavigationRequirementsEntity optionnavigationrequirementsentity =
        Provider.of<OptionNavigationRequirementsEntity>(context);
    return Positioned(
        bottom: 20,
        right: 16,
        left: 16,
        child: BlocBuilder<TestItemCubit, TestItemState>(
            builder: (context, state) {
          return Custom_Loading_Widget(
            isLoading: state is AddTestItemLoading ||
                state is QuestionsImagesUploadedingLoading ||
                state is QuestionsSolutionsImagesUploadedingLoading,
            child: Custombutton(
                text: currentIndex == 2 ? LocaleKeys.addExam : LocaleKeys.save,
                color: KSecondaryColor,
                textColor: Colors.white,
                onPressed: () {
                  actions(optionnavigationrequirementsentity,
                      widget.courseTestEntity, currentIndex, context);
                }),
          );
        }));
  }

  void actions(
      OptionNavigationRequirementsEntity optionnavigationrequirementsentity,
      CourseTestEntity courseTestEntity,
      int index,
      BuildContext context) {
    if (index == 0) {
      if (widget.examDetailsFormKey.currentState != null) {
        if (widget.examDetailsFormKey.currentState!.validate()) {
          widget.examDetailsFormKey.currentState!.save();
          widget.pageController.animateToPage(1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      }
    } else if (widget.currentStep == 1) {
      if (widget.questionsFormKey.currentState != null) {
        if (widget.questionsFormKey.currentState!.validate()) {
          widget.questionsFormKey.currentState!.save();
          widget.pageController.animateToPage(2,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      }
    } else if (widget.currentStep == 2) {
      context.read<TestItemCubit>().uploadTestQuestionsImages(
            test: courseTestEntity,
          );
    }
  }
}
