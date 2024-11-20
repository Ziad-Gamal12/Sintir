import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomChatTextField.dart';
import 'package:sintir/Features/AI_Chat/presentation/views/widgets/aiChatListView.dart';

class AichatviewBody extends StatelessWidget {
  AichatviewBody({super.key});
  TextEditingController controller = TextEditingController();
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
                controller: controller,
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
