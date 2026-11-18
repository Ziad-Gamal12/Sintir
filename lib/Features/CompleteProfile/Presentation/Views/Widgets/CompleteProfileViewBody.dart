// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/helper/ProfileCompleteness.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Entities/CompleteProfilePurpose.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Manager/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CompleteProfileViewBody extends StatefulWidget {
  const CompleteProfileViewBody({super.key, required this.purpose});

  final CompleteProfilePurpose purpose;

  @override
  State<CompleteProfileViewBody> createState() =>
      _CompleteProfileViewBodyState();
}

class _CompleteProfileViewBodyState extends State<CompleteProfileViewBody> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController phoneController;
  String? educationLevel;
  String gender = '';

  bool get isPayment => widget.purpose == CompleteProfilePurpose.payment;

  @override
  void initState() {
    super.initState();
    final user = context.read<CompleteProfileCubit>().currentUser;
    final name = ProfileCompleteness.splitName(user);
    firstNameController = TextEditingController(text: name.first);
    lastNameController = TextEditingController(text: name.last);
    phoneController = TextEditingController(
      text: ProfileCompleteness.isValidPhone(user.phoneNumber)
          ? ProfileCompleteness.normalizePhone(user.phoneNumber)
          : '',
    );
    final level = user.studentExtraDataEntity?.educationLevel ?? '';
    educationLevel = ProfileCompleteness.educationLevels.contains(level)
        ? level
        : null;
    gender = const {'Male', 'Female'}.contains(user.gender) ? user.gender : '';
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(formKey.currentState?.validate() ?? false)) return;
    context.read<CompleteProfileCubit>().save(
      ProfileCompletionInput(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        educationLevel: educationLevel ?? '',
        gender: gender,
      ),
    );
  }

  void _finish({required bool saved}) {
    if (isPayment) {
      context.pop(saved);
    } else {
      context.go(Homeview.routeName);
    }
  }

  void _onState(BuildContext context, CompleteProfileState state) {
    if (state is CompleteProfileSaved) {
      CustomSnackBar.show(
        context,
        message: LocaleKeys.completeProfileSaved,
        type: SnackType.success,
      );
      _finish(saved: true);
    } else if (state is CompleteProfileFailure) {
      CustomSnackBar.show(
        context,
        message: state.message,
        type: SnackType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    return BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
      listener: _onState,
      builder: (context, state) {
        final saving = state is CompleteProfileSaving;
        return Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding,
              vertical: KVerticalPadding,
            ),
            children: [
              Icon(
                isPayment ? Icons.phone_iphone_rounded : Icons.badge_outlined,
                size: 48,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                isPayment
                    ? LocaleKeys.completeProfilePaymentSubtitle
                    : LocaleKeys.completeProfileSubtitle,
                key: const ValueKey('complete-profile-subtitle'),
                textAlign: TextAlign.center,
                style: styles.semiBold14.copyWith(
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      key: const ValueKey('complete-profile-first-name'),
                      controller: firstNameController,
                      hintText: LocaleKeys.firstName,
                      prefixIcon: Icons.person_outline,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: (value) => (value ?? '').trim().isEmpty
                          ? LocaleKeys.enterFirstName
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      key: const ValueKey('complete-profile-last-name'),
                      controller: lastNameController,
                      hintText: LocaleKeys.lastName,
                      prefixIcon: Icons.person_outline,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: (value) => (value ?? '').trim().isEmpty
                          ? LocaleKeys.enterLastName
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                key: const ValueKey('complete-profile-phone'),
                controller: phoneController,
                hintText: LocaleKeys.phoneNumber,
                prefixIcon: Icons.phone_outlined,
                obscureText: false,
                textInputType: TextInputType.phone,
                maxLength: 11,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  final text = (value ?? '').trim();
                  if (text.isEmpty) return LocaleKeys.phoneRequired;
                  if (!ProfileCompleteness.isValidPhone(text)) {
                    return LocaleKeys.phoneInvalid;
                  }
                  return null;
                },
              ),
              Text(
                LocaleKeys.completeProfilePhoneHint,
                style: styles.regular14.copyWith(
                  color: theme.hintColor,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                key: const ValueKey('complete-profile-level'),
                initialValue: educationLevel,
                isExpanded: true,
                decoration: InputDecoration(
                  hintText: LocaleKeys.studentEducationLevel,
                  prefixIcon: const Icon(Icons.school_outlined, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                items: [
                  for (final level in ProfileCompleteness.educationLevels)
                    DropdownMenuItem(value: level, child: Text(level)),
                ],
                onChanged: saving
                    ? null
                    : (value) => setState(() => educationLevel = value),
                validator: (value) => value == null
                    ? LocaleKeys.completeProfileLevelRequired
                    : null,
              ),
              const SizedBox(height: 16),
              Text(LocaleKeys.profileGender, style: styles.semiBold14),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    key: const ValueKey('complete-profile-gender-male'),
                    label: Text(LocaleKeys.male),
                    selected: gender == 'Male',
                    onSelected: saving
                        ? null
                        : (_) => setState(() => gender = 'Male'),
                  ),
                  ChoiceChip(
                    key: const ValueKey('complete-profile-gender-female'),
                    label: Text(LocaleKeys.female),
                    selected: gender == 'Female',
                    onSelected: saving
                        ? null
                        : (_) => setState(() => gender = 'Female'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 52,
                child: FilledButton(
                  key: const ValueKey('complete-profile-save'),
                  onPressed: saving ? null : _submit,
                  child: saving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.4),
                        )
                      : Text(LocaleKeys.completeProfileSave),
                ),
              ),
              if (!isPayment) ...[
                const SizedBox(height: 8),
                TextButton(
                  key: const ValueKey('complete-profile-skip'),
                  onPressed: saving ? null : () => _finish(saved: false),
                  child: Text(LocaleKeys.completeProfileSkip),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
