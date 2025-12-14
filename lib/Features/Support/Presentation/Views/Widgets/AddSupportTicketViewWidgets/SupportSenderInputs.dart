// support_sender_inputs.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/locale_keys.dart';

class SupportSenderInputs extends StatelessWidget {
  const SupportSenderInputs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.senderData,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Full Name
        CustomTextField(
          hintText: LocaleKeys.fullName,
          obscureText: false,
          textInputType: TextInputType.text,
          onSaved: (val) {
            context.read<SupportTicketEntity>().sender.name = val ?? "";
          },
          validator: (value) =>
              value == null || value.isEmpty ? LocaleKeys.enterName : null,
        ),
        const SizedBox(height: 16),

        // Email Address
        CustomTextField(
          hintText: LocaleKeys.emailHint,
          obscureText: false,
          textInputType: TextInputType.emailAddress,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return LocaleKeys.emailRequired;
            }
            return null;
          },
          onSaved: (val) {
            context.read<SupportTicketEntity>().sender.email = val ?? "";
          },
        ),
        const SizedBox(height: 16),

        // Phone Number
        CustomTextField(
          hintText: LocaleKeys.phoneNumber,
          obscureText: false,
          textInputType: TextInputType.phone,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return LocaleKeys.phoneRequired;
            }
            return null;
          },
          onSaved: (val) {
            context.read<SupportTicketEntity>().sender.phone = val ?? "";
          },
        ),
      ],
    );
  }
}
