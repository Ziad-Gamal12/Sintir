import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/responsive/max_width_box.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
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
  static const double _bottomOffset = 20;

  int currentIndex = 0;

  /// Floats the step's feedback above this button instead of over it, so the
  /// teacher can press it again as soon as the problem is fixed.
  EdgeInsets get _snackBarMarginAboveButton {
    final buttonHeight = context.size?.height ?? 56;
    return EdgeInsets.fromLTRB(20, 10, 20, _bottomOffset + buttonHeight + 12);
  }

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
      bottom: _bottomOffset,
      right: 16,
      left: 16,
      child: MaxWidthBox(
        alignment: Alignment.bottomCenter,
        child: BlocBuilder<TestItemCubit, TestItemState>(
          builder: (context, state) {
            return Custom_Loading_Widget(
              isLoading:
                  state is AddTestItemLoading ||
                  state is QuestionsImagesUploadedingLoading ||
                  state is QuestionsSolutionsImagesUploadedingLoading,
              child: Custombutton(
                text: currentIndex == 2 ? LocaleKeys.addExam : LocaleKeys.save,
                color: KSecondaryColor,
                textColor: Colors.white,
                onPressed: () {
                  actions(
                    optionnavigationrequirementsentity,
                    widget.courseTestEntity,
                    currentIndex,
                    context,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void actions(
    OptionNavigationRequirementsEntity optionnavigationrequirementsentity,
    CourseTestEntity courseTestEntity,
    int index,
    BuildContext context,
  ) {
    if (index == 0) {
      if (widget.examDetailsFormKey.currentState != null) {
        if (widget.examDetailsFormKey.currentState!.validate()) {
          widget.examDetailsFormKey.currentState!.save();
          widget.pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    } else if (widget.currentStep == 1) {
      _submitQuestions(courseTestEntity, context);
    } else if (widget.currentStep == 2) {
      context.read<TestItemCubit>().uploadTestQuestionsImages(
        test: courseTestEntity,
      );
    }
  }

  /// Moves on to the review step only when the exam has questions, every
  /// question has a correct answer marked, and every field is valid. Otherwise
  /// the teacher is told what's missing and taken to the first such question.
  void _submitQuestions(CourseTestEntity test, BuildContext context) {
    final form = widget.questionsFormKey.currentState;
    if (form == null) return;

    if (test.questions.isEmpty) {
      CustomSnackBar.show(
        context,
        message: LocaleKeys.errorNoQuestions,
        type: SnackType.warning,
        margin: _snackBarMarginAboveButton,
      );
      return;
    }

    // Validate first so empty fields are marked too, not only the answers.
    final fieldsValid = form.validate();

    final missing = test.questionsWithoutCorrectAnswer;
    if (missing.isNotEmpty) {
      context.read<TestItemCubit>().flagQuestionsMissingCorrectAnswer(
        questions: missing,
      );
      CustomSnackBar.show(
        context,
        message: LocaleKeys.missingCorrectAnswers(
          LocaleFormatter.number(
            missing.length,
            Localizations.localeOf(context).languageCode,
          ),
        ),
        type: SnackType.warning,
        margin: _snackBarMarginAboveButton,
      );
      return;
    }
    if (!fieldsValid) return;

    form.save();
    widget.pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
