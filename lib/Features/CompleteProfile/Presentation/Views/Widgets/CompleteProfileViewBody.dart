// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/helper/ProfileCompleteness.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Entities/CompleteProfilePurpose.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Enums/SiginInMethod.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Manager/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Views/Widgets/AuthProviderBadge.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Views/Widgets/CompleteProfileEducationalLevelField.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Views/Widgets/CompleteProfileFirstAndLastNameFields.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Views/Widgets/CompleteProfileGenderSelector.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Views/Widgets/CompleteProfileIntroSection.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Views/Widgets/CompleteProfilePhoneNumberField.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/EducationLevelDropdownEntityItem.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CompleteProfileViewBody extends StatefulWidget {
  const CompleteProfileViewBody({super.key, required this.method});
  final SiginInMethod? method;
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
      listener: (BuildContext context, CompleteProfileState state) {
        if (state is CompleteProfileSaved) {
          CustomSnackBar.show(
            context,
            message: LocaleKeys.completeProfileSaved,
            type: SnackType.success,
          );
          GoRouter.of(context).go(Homeview.routeName);
        } else if (state is CompleteProfileFailure) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackType.error,
          );
        }
      },
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding,
            vertical: KVerticalPadding,
          ),
          children: [
            AuthProviderBadge(method: widget.method),
            const SizedBox(height: 12),
            CompleteProfileIntroSection(styles: styles, theme: theme),
            const SizedBox(height: 24),
            CompleteProfileFirstAndLastNameFields(
              firstNameController: firstNameController,
              lastNameController: lastNameController,
            ),
            const SizedBox(height: 16),
            CompleteProfilePhoneNumberField(phoneController: phoneController),
            const SizedBox(height: 16),
            CompleteProfileEducationalLevelField(
              theme: theme,
              vallueChanged: (label) {
                if (label != null) {
                  setState(
                    () => educationLevel =
                        EducationLevelDropdownEntityItem.getValueByLabel(label),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            Text(LocaleKeys.profileGender, style: styles.semiBold14),
            const SizedBox(height: 8),
            CompleteProfileGenderSelector(
              selectedGender: gender,
              onGenderChanged: (value) => setState(() => gender = value),
            ),
            const SizedBox(height: 32),
            BlocSelector<CompleteProfileCubit, CompleteProfileState, bool>(
              selector: (state) {
                log(state.toString());
                return state is CompleteProfileSaving;
              },
              builder: (context, isSaving) {
                return Custombutton(
                  text: LocaleKeys.completeProfileSave,
                  color: theme.colorScheme.primary,
                  textColor: Colors.white,
                  onPressed: isSaving ? () {} : _submit,
                  child: isSaving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: Colors.white,
                          ),
                        )
                      : null,
                );
              },
            ),
            const SizedBox(height: 8),
            TextButton(
              key: const ValueKey('complete-profile-skip'),
              onPressed: () {
                GoRouter.of(context).go(Homeview.routeName);
              },
              child: Text(LocaleKeys.completeProfileSkip),
            ),
          ],
        ),
      ),
    );
  }
}
