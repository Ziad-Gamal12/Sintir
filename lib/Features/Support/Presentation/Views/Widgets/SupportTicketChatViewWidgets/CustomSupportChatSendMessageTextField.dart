import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomChatTextField.dart';
import 'package:sintir/Features/Support/Presentation/Managers/support_chat_cubit/support_chat_cubit.dart';
import 'package:sintir/locale_keys.dart';

class CustomSupportChatSendMessageTextField extends StatelessWidget {
  const CustomSupportChatSendMessageTextField({
    super.key,
    required this.formKey,
    required this.controller,
    required this.ticketId,
    required this.onSend,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String ticketId;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SupportChatCubit, SupportChatState, bool>(
      selector: (state) => state is SendMessageLoading,
      builder: (context, isLoading) {
        return CustomChatTextField(
          onPressed: onSend,
          controller: controller,
          isLoading: isLoading,
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return LocaleKeys.fieldCannotBeEmpty;
            }
            return null;
          },
        );
      },
    );
  }
}
