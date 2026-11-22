import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/LogOutDialog.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/user_personal_details_cubit/user_personal_details_cubit.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileItemActionsButtons.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileViewBodyUserInfo.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  static const double _singleColumnMaxWidth = 720;
  static const double _wideMaxWidth = 1040;
  static const double _wideLogoutMaxWidth = 360;
  static const double _navigationBarSpace = 80;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserPersonalDetailsCubit, UserPersonalDetailsState>(
      listener: _handleStateChanges,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bottomInset = context.hasSideNavigation
              ? KVerticalPadding
              : KVerticalPadding + _navigationBarSpace;
          if (constraints.maxWidth >= Breakpoints.expanded) {
            return _buildWide(context, constraints.maxWidth, bottomInset);
          }
          final gutter = ContentWidth.gutter(
            constraints.maxWidth,
            _singleColumnMaxWidth,
            min: KHorizontalPadding,
          );
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  gutter,
                  KVerticalPadding,
                  gutter,
                  bottomInset,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const ProfileViewBodyUserInfo(),
                    const SizedBox(height: 20),

                    const ProfileItemActionsButtons(),

                    const SizedBox(height: 28),

                    // 4. Logout Action
                    _buildLogoutButton(context),
                    const SizedBox(height: 12),
                    _buildVersion(),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWide(BuildContext context, double width, double bottomInset) {
    final gutter = ContentWidth.gutter(width, _wideMaxWidth, min: 24);
    final showLogout = !context.hasSideNavigation;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(gutter, 24, gutter, bottomInset),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const _ProfileHeroCard(),
              const SizedBox(height: 28),
              const ProfileItemActionsButtons(),
              const SizedBox(height: 32),
              if (showLogout) ...[
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: _wideLogoutMaxWidth,
                    ),
                    child: _buildLogoutButton(context),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              _buildVersion(),
            ]),
          ),
        ),
      ],
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
    return SizedBox(
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
    );
  }

  Widget _buildVersion() {
    return Center(
      child: Text(
        "Version $currentVersion",
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ProfileHeroCard extends StatelessWidget {
  const _ProfileHeroCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          primary.withValues(alpha: isDark ? 0.08 : 0.05),
          theme.cardColor,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: primary.withValues(alpha: isDark ? 0.18 : 0.12),
        ),
      ),
      child: const ProfileViewBodyUserInfo(prominent: true),
    );
  }
}
