import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomChatTextField.dart';

class CustomSupportChatTextField extends StatefulWidget {
  const CustomSupportChatTextField({super.key});

  @override
  State<CustomSupportChatTextField> createState() =>
      _CustomSupportChatTextFieldState();
}

class _CustomSupportChatTextFieldState
    extends State<CustomSupportChatTextField> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Expanded(
                child: CustomChatTextField(
                    onPressed: () {},
                    controller: controller,
                    validator: (val) {
                      return null;
                    })),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.photo,
                  size: 30,
                ))
          ],
        ));
  }
}
