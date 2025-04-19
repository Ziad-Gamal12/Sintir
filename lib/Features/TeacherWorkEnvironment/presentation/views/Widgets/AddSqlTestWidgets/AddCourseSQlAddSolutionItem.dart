import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/widgets/CustomRadioWidget.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';

class AddCourseSQlAddSolutionItem extends StatefulWidget {
  const AddCourseSQlAddSolutionItem({
    super.key,
    required this.coursetestquestionsolutionentity,
    required this.groupValue,
    required this.onChange,
  });
  final Coursetestquestionsolutionentity coursetestquestionsolutionentity;
  final String groupValue;
  final ValueChanged<String?> onChange;

  @override
  State<AddCourseSQlAddSolutionItem> createState() =>
      _AddCourseSQlAddSolutionItemState();
}

class _AddCourseSQlAddSolutionItemState
    extends State<AddCourseSQlAddSolutionItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSectionsCubit, CourseSectionsState>(
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
              child: Customteaxtfield(
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
