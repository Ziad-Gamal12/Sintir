import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/widgets/CustomRadioWidget.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class AddCourseExamAddSolutionItem extends StatefulWidget {
  const AddCourseExamAddSolutionItem({
    super.key,
    required this.coursetestquestionsolutionentity,
    required this.groupValue,
    required this.onChange,
  });
  final Coursetestquestionsolutionentity coursetestquestionsolutionentity;
  final String groupValue;
  final ValueChanged<String?> onChange;

  @override
  State<AddCourseExamAddSolutionItem> createState() =>
      _AddCourseExamAddSolutionItemState();
}

class _AddCourseExamAddSolutionItemState
    extends State<AddCourseExamAddSolutionItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestItemCubit, TestItemState>(
      builder: (context, state) {
        return Row(
          children: [
            CustomRadioWidget(
                value: widget.coursetestquestionsolutionentity.answer,
                groupValue: widget.groupValue,
                onchange: (value) {
                  widget.onChange(value);
                }),
            Expanded(
              child: CustomTextField(
                  controller: widget
                      .coursetestquestionsolutionentity.solutionController,
                  hintText: "يرجى كتابه الاجابه هنا ...",
                  obscureText: false,
                  textInputType: TextInputType.text,
                  onSaved: (value) {
                    widget.coursetestquestionsolutionentity.answer = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "ادخل الاجابه";
                    }
                    return null;
                  }),
            ),
          ],
        );
      },
    );
  }
}
