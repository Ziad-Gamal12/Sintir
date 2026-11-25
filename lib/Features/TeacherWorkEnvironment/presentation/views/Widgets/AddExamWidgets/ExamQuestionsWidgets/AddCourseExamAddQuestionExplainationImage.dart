import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/ExamQuestionImageTile.dart';
import 'package:sintir/locale_keys.dart';

/// The image that explains the question's answer. The question holds the
/// picked file; the cubit's pick states only refresh this question's tile.
class AddCourseExamAddQuestionExplainationImage extends StatefulWidget {
  const AddCourseExamAddQuestionExplainationImage({
    super.key,
    required this.coursetestquestionentity,
  });

  final CourseTestQuestionEntity coursetestquestionentity;

  @override
  State<AddCourseExamAddQuestionExplainationImage> createState() =>
      _AddCourseExamAddQuestionExplainationImageState();
}

class _AddCourseExamAddQuestionExplainationImageState
    extends State<AddCourseExamAddQuestionExplainationImage> {
  CourseTestQuestionEntity get _question => widget.coursetestquestionentity;

  bool _isForThisQuestion(TestItemState state) => switch (state) {
    PickQuestionSolutionImageLoading(:final question) ||
    PickQuestionSolutionImageSuccess(:final question) ||
    PickQuestionSolutionImageFailure(
      :final question,
    ) => identical(question, _question),
    _ => false,
  };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestItemCubit, TestItemState>(
      listenWhen: (previous, current) =>
          current is PickQuestionSolutionImageFailure &&
          _isForThisQuestion(current),
      listener: (context, state) => CustomSnackBar.show(
        context,
        message: (state as PickQuestionSolutionImageFailure).errMessage,
        type: SnackType.error,
      ),
      buildWhen: (previous, current) => _isForThisQuestion(current),
      builder: (context, state) {
        return ExamQuestionImageTile(
          label: LocaleKeys.answerImage,
          file: _question.solutionFile,
          isLoading:
              state is PickQuestionSolutionImageLoading &&
              _isForThisQuestion(state),
          onPick: () => context.read<TestItemCubit>().pickQuestionSolutionImage(
            question: _question,
          ),
          onRemove: () => setState(() => _question.solutionFile = null),
        );
      },
    );
  }
}
