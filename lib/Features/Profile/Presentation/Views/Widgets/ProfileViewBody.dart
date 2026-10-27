import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/LogOutDialog.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/user_personal_details_cubit/user_personal_details_cubit.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileItemActionsButtons.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileViewBodyUserInfo.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserPersonalDetailsCubit, UserPersonalDetailsState>(
      listener: _handleStateChanges,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              KHorizontalPadding,
              KVerticalPadding,
              KHorizontalPadding,
              KVerticalPadding + 80,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const ProfileViewBodyUserInfo(),
                const SizedBox(height: 20),

                const ProfileItemActionsButtons(),

                const SizedBox(height: 28),

                // 4. Logout Action
                _buildLogoutButton(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // Extracted logic for cleaner build method
  void _handleStateChanges(
      BuildContext context, UserPersonalDetailsState state) {
    if (state is UpdatedUserProfilePicSuccess) {
      CustomSnackBar.show(context,
          message: LocaleKeys.successImageChanged, type: SnackType.success);
    } else if (state is UpdatedUserProfilePicFailure) {
      CustomSnackBar.show(context,
          message: state.errMessage, type: SnackType.error);
    }
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 54,
          width: double.infinity,
          child: Material(
            color: Colors.red.withValues(alpha: 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.red.withValues(alpha: 0.25)),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => const LogoutDialog(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.logout_rounded,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(LocaleKeys.logout,
                      style: AppTextStyles(context)
                          .semiBold16
                          .copyWith(color: Colors.redAccent)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Version $currentVersion",
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
