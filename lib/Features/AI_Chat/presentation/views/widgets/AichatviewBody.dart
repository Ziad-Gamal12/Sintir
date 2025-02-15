// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomChatTextField.dart';
import 'package:sintir/Features/AI_Chat/presentation/views/widgets/aiChatListView.dart';

class AiChatViewBody extends StatelessWidget {
  AiChatViewBody({super.key});
  TextEditingController customAiChatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Aichatlistview(),
        Positioned(
          bottom: 10,
          right: 10,
          left: 10,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomChatTextField(
                controller: customAiChatController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "ادخل النص";
                  }
                  return null;
                }),
          ),
        )
      ],
    );
  }
}
