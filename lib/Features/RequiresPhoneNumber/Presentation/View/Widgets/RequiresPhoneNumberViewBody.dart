import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ProfileCompleteness.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Views/Widgets/CompleteProfilePhoneNumberField.dart';
import 'package:sintir/Features/RequiresPhoneNumber/Presentation/Manager/UpdateUserPhoneNumberCubit/update_user_phone_number_cubit.dart';
import 'package:sintir/Features/RequiresPhoneNumber/Presentation/View/Widgets/requires_phone_number_actions.dart';
import 'package:sintir/Features/RequiresPhoneNumber/Presentation/View/Widgets/requires_phone_number_course_card.dart';
import 'package:sintir/Features/RequiresPhoneNumber/Presentation/View/Widgets/requires_phone_number_header.dart';
import 'package:sintir/locale_keys.dart';

class RequiresPhoneNumberViewBody extends StatefulWidget {
  const RequiresPhoneNumberViewBody({super.key, required this.courseName});

  final String courseName;

  @override
  State<RequiresPhoneNumberViewBody> createState() =>
      _RequiresPhoneNumberViewBodyState();
}

class _RequiresPhoneNumberViewBodyState
    extends State<RequiresPhoneNumberViewBody> {
  late TextEditingController phoneController;
  late GlobalKey<FormState> formKey;
  final user = getUserData();

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = MediaQuery.sizeOf(context).width >= 600;

    final surfaceColor = isDark ? const Color(0xFF161B26) : Colors.white;
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFE2E8F0);

    return BlocListener<UpdateUserPhoneNumberCubit, UpdateUserPhoneNumberState>(
      listener: (context, state) {
        if (state is UpdateUserPhoneNumberSuccess) {
          CustomSnackBar.show(
            context,
            message: LocaleKeys.completeProfileSaved,
            type: SnackType.success,
          );
          GoRouter.of(context).pop(true);
        } else if (state is UpdateUserPhoneNumberFailure) {
          CustomSnackBar.show(
            context,
            message: state.errMessage,
            type: SnackType.error,
          );
        }
      },
      child: Form(
        key: formKey,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 540 : double.infinity,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: isDesktop
                  ? BorderRadius.circular(24)
                  : const BorderRadius.vertical(top: Radius.circular(28)),
              border: isDesktop ? Border.all(color: borderColor) : null,
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  isDesktop ? 28 : 20,
                  isDesktop ? 20 : 12,
                  isDesktop ? 28 : 20,
                  isDesktop ? 28 : 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RequiresPhoneNumberHeader(isDesktop: isDesktop),
                    SizedBox(height: isDesktop ? 24 : 20),
                    RequiresPhoneNumberCourseCard(
                      courseName: widget.courseName,
                    ),
                    const SizedBox(height: 20),
                    CompleteProfilePhoneNumberField(
                      phoneController: phoneController,
                    ),
                    const SizedBox(height: 24),
                    RequiresPhoneNumberActions(
                      isDesktop: isDesktop,
                      formKey: formKey,
                      phoneController: phoneController,
                      uid: user.uid,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
