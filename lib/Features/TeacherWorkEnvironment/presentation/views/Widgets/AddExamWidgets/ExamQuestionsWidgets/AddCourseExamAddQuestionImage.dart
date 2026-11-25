import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/ExamQuestionImageTile.dart';
import 'package:sintir/locale_keys.dart';

/// The image shown with the question. The question holds the picked file;
/// the cubit's pick states only refresh this question's tile.
class AddCourseExamAddQuestionImage extends StatefulWidget {
  const AddCourseExamAddQuestionImage({
    super.key,
    required this.coursetestquestionentity,
  });

  final CourseTestQuestionEntity coursetestquestionentity;

  @override
  State<AddCourseExamAddQuestionImage> createState() =>
      _AddCourseExamAddQuestionImageState();
}

class _AddCourseExamAddQuestionImageState
    extends State<AddCourseExamAddQuestionImage> {
  CourseTestQuestionEntity get _question => widget.coursetestquestionentity;

  bool _isForThisQuestion(TestItemState state) => switch (state) {
    PickQuestionImageLoading(:final question) ||
    PickQuestionImageSuccess(:final question) ||
    PickQuestionImageFailure(:final question) => identical(question, _question),
    _ => false,
  };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestItemCubit, TestItemState>(
      listenWhen: (previous, current) =>
          current is PickQuestionImageFailure && _isForThisQuestion(current),
      listener: (context, state) => CustomSnackBar.show(
        context,
        message: (state as PickQuestionImageFailure).errMessage,
        type: SnackType.error,
      ),
      buildWhen: (previous, current) => _isForThisQuestion(current),
      builder: (context, state) {
        return ExamQuestionImageTile(
          label: LocaleKeys.questionImage,
          file: _question.imageFile,
          isLoading:
              state is PickQuestionImageLoading && _isForThisQuestion(state),
          onPick: () => context.read<TestItemCubit>().pickQuestionImage(
            question: _question,
          ),
          onRemove: () => setState(() => _question.imageFile = null),
        );
      },
    );
  }
}
