import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
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
    final theme = Theme.of(context);

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
              KVerticalPadding + 20,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 1. User Info Section
                const ProfileViewBodyUserInfo(),

                const SizedBox(height: 24),

                // 2. Subtle Divider
                Divider(
                  color: theme.dividerColor.withOpacity(0.1),
                  thickness: 1,
                ),

                const SizedBox(height: 16),

                const ProfileItemActionsButtons(),

                const SizedBox(height: 48),

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
        Custombutton(
          text: LocaleKeys.logout,
          color: Colors.red,
          textColor: Colors.white,
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) => const LogoutDialog(),
            );
          },
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
