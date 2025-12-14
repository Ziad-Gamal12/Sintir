// support_ticket_details_inputs.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/AddSupportTicketViewWidgets/CustomAddSupportTicketCategoryDropdwonButton.dart';
import 'package:sintir/locale_keys.dart';

class SupportTicketDetailsInputs extends StatelessWidget {
  const SupportTicketDetailsInputs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.problemDetails,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Issue Title
        CustomTextField(
          hintText: LocaleKeys.problemTitleHint,
          obscureText: false,
          textInputType: TextInputType.text,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return LocaleKeys.problemTitleRequired;
            }
            return null;
          },
          onSaved: (val) {
            context.read<SupportTicketEntity>().title = val ?? "";
          },
        ),
        const SizedBox(height: 16),

        // Category Dropdown
        const CustomAddSupportTicketCategoryDropdwonButton(),

        const SizedBox(height: 16),

        // Issue Description
        CustomTextField(
          maxLines: 6,
          hintText: LocaleKeys.problemDescriptionHint,
          obscureText: false,
          textInputType: TextInputType.text,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return LocaleKeys.problemDescriptionRequired;
            }
            return null;
          },
          onSaved: (val) {
            context.read<SupportTicketEntity>().description = val ?? "";
          },
        ),
      ],
    );
  }
}
