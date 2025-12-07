import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/locale_keys.dart';

class AddQuestionButton extends StatelessWidget {
  const AddQuestionButton({
    super.key,
    required this.coursetestentity,
  });

  final CourseTestEntity coursetestentity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.grey.shade300,
          height: 40,
        ),
        Custombutton(
            text: LocaleKeys.addQuestion,
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              context
                  .read<TestItemCubit>()
                  .addNewQuestion(coursetestentity: coursetestentity);
            }),
        const SizedBox(height: 120),
      ],
    );
  }
}
