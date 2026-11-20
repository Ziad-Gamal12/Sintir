import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTitledTextField.dart';
import 'package:sintir/locale_keys.dart';

class CompleteProfileFirstAndLastNameFields extends StatelessWidget {
  const CompleteProfileFirstAndLastNameFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTitledTextField(
            title: LocaleKeys.firstName,
            key: const ValueKey('complete-profile-first-name'),
            controller: firstNameController,
            hintText: LocaleKeys.firstName,
            prefixIcon: Icons.person_outline,

            obscureText: false,
            textInputType: TextInputType.name,
            validator: (value) =>
                (value ?? '').trim().isEmpty ? LocaleKeys.enterFirstName : null,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTitledTextField(
            key: const ValueKey('complete-profile-last-name'),
            title: LocaleKeys.lastName,
            controller: lastNameController,
            hintText: LocaleKeys.lastName,
            prefixIcon: Icons.people_outline,
            obscureText: false,
            textInputType: TextInputType.name,
            validator: (value) =>
                (value ?? '').trim().isEmpty ? LocaleKeys.enterLastName : null,
          ),
        ),
      ],
    );
  }
}
