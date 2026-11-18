// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AppConfirmationSheet.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomPasswordTextField.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/ChoosingUserKindView.dart';
import 'package:sintir/Features/Profile/Domain/Repos/AccountDeletionRepo.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/DeleteAccountViewWidgets/DeleteAccountInfoCard.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class DeleteAccountViewBody extends StatefulWidget {
  const DeleteAccountViewBody({super.key});

  @override
  State<DeleteAccountViewBody> createState() => _DeleteAccountViewBodyState();
}

class _DeleteAccountViewBodyState extends State<DeleteAccountViewBody> {
  static const Color danger = Color(0xFFC62828);
  final passwordController = TextEditingController();
  bool understood = false;
  bool acknowledgeBalance = false;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = getUserData();
    final isTeacher = user.role == BackendEndpoints.teacherRole;
    final wallet = user.teacherExtraDataEntity?.wallet;
    final balance = isTeacher ? (wallet?.balance ?? 0) : 0.0;
    final payoutPending = isTeacher ? (wallet?.payoutPending ?? 0) : 0.0;
    final method = context.read<DeleteAccountCubit>().signInMethod;
    final styles = AppTextStyles(context);
    final theme = Theme.of(context);

    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listener: _onState,
      builder: (context, state) {
        final loading = state is DeleteAccountLoading;
        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding,
            vertical: KVerticalPadding,
          ),
          children: [
            DeleteAccountInfoCard(
              icon: Icons.warning_amber_rounded,
              color: danger,
              title: LocaleKeys.accountDeleteWarningTitle,
              lines: [LocaleKeys.accountDeleteWarningBody],
            ),
            const SizedBox(height: 14),
            DeleteAccountInfoCard(
              icon: Icons.delete_outline_rounded,
              color: theme.colorScheme.onSurfaceVariant,
              title: LocaleKeys.accountDeleteRemovedTitle,
              lines: [
                LocaleKeys.accountDeleteRemovedProfile,
                LocaleKeys.accountDeleteRemovedLearning,
                LocaleKeys.accountDeleteRemovedReviews,
                LocaleKeys.accountDeleteRemovedSupport,
                if (isTeacher) LocaleKeys.accountDeleteRemovedUnsoldCourses,
              ],
            ),
            const SizedBox(height: 14),
            DeleteAccountInfoCard(
              icon: Icons.inventory_2_outlined,
              color: KMainColor,
              title: LocaleKeys.accountDeleteKeptTitle,
              lines: [
                LocaleKeys.accountDeleteKeptPayments,
                if (isTeacher) LocaleKeys.accountDeleteKeptSoldCourses,
              ],
            ),
            if (payoutPending > 0) ...[
              const SizedBox(height: 14),
              DeleteAccountInfoCard(
                icon: Icons.hourglass_top_rounded,
                color: KSecondaryColor,
                title: LocaleKeys.accountDeletePayoutPendingTitle,
                lines: [LocaleKeys.accountDeletePayoutPending],
              ),
            ],
            if (balance > 0) ...[
              const SizedBox(height: 14),
              DeleteAccountInfoCard(
                icon: Icons.account_balance_wallet_outlined,
                color: KSecondaryColor,
                title: LocaleKeys.accountDeleteBalanceTitle(
                  balance.toStringAsFixed(2),
                ),
                lines: [LocaleKeys.accountDeleteBalanceBody],
              ),
              CheckboxListTile(
                key: const ValueKey('delete-account-ack-balance'),
                contentPadding: EdgeInsets.zero,
                value: acknowledgeBalance,
                activeColor: danger,
                onChanged: loading
                    ? null
                    : (value) =>
                        setState(() => acknowledgeBalance = value ?? false),
                title: Text(
                  LocaleKeys.accountDeleteBalanceAcknowledge,
                  style: styles.regular14,
                ),
              ),
            ],
            const SizedBox(height: 18),
            if (method == AccountSignInMethod.password) ...[
              Text(LocaleKeys.accountDeletePasswordLabel,
                  style: styles.semiBold14),
              const SizedBox(height: 8),
              CustomPasswordTextField(controller: passwordController),
            ] else
              Text(
                method == AccountSignInMethod.google
                    ? LocaleKeys.accountDeleteGoogleNote
                    : method == AccountSignInMethod.facebook
                        ? LocaleKeys.accountDeleteFacebookNote
                        : LocaleKeys.accountDeleteSignInNote,
                style: styles.regular13.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                  height: 1.6,
                ),
              ),
            const SizedBox(height: 8),
            CheckboxListTile(
              key: const ValueKey('delete-account-understood'),
              contentPadding: EdgeInsets.zero,
              value: understood,
              activeColor: danger,
              onChanged: loading
                  ? null
                  : (value) => setState(() => understood = value ?? false),
              title: Text(
                LocaleKeys.accountDeleteUnderstand,
                style: styles.regular14,
              ),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: passwordController,
              builder: (context, password, _) {
                final ready = understood &&
                    (balance <= 0 || acknowledgeBalance) &&
                    (method != AccountSignInMethod.password ||
                        password.text.isNotEmpty);
                return SizedBox(
                  height: 50,
                  child: FilledButton.icon(
                    key: const ValueKey('delete-account-button'),
                    style: FilledButton.styleFrom(
                      backgroundColor: danger,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: ready && !loading
                        ? () => _confirm(context, method, balance > 0)
                        : null,
                    icon: loading
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.white,
                          ),
                    label: Text(
                      loading
                          ? LocaleKeys.accountDeleteInProgress
                          : LocaleKeys.accountDeleteButton,
                      style: styles.semiBold14.copyWith(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirm(
    BuildContext context,
    AccountSignInMethod method,
    bool hasBalance,
  ) async {
    FocusScope.of(context).unfocus();
    final cubit = context.read<DeleteAccountCubit>();
    final confirmed = await AppConfirmationSheet.show(
      context,
      icon: Icons.delete_forever_rounded,
      color: danger,
      title: LocaleKeys.accountDeleteConfirmTitle,
      body: LocaleKeys.accountDeleteConfirmBody,
      confirmLabel: LocaleKeys.accountDeleteButton,
    );
    if (!confirmed || !mounted) return;
    await cubit.deleteAccount(
      password: method == AccountSignInMethod.password
          ? passwordController.text
          : null,
      acknowledgeBalance: hasBalance && acknowledgeBalance,
    );
  }

  void _onState(BuildContext context, DeleteAccountState state) {
    if (state is DeleteAccountFailure) {
      CustomSnackBar.show(context, message: state.message, type: SnackType.error);
    } else if (state is DeleteAccountSuccess) {
      CustomSnackBar.show(
        context,
        message: LocaleKeys.accountDeleteDone,
        type: SnackType.success,
      );
      GoRouter.of(context).go(ChoosingUserKindView.routeName);
    }
  }
}
