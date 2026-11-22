import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/user_personal_details_cubit/user_personal_details_cubit.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UpadateUserProfilePicIconButton.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserAvatar.dart';
import 'package:sintir/locale_keys.dart';

class ProfileViewBodyUserInfo extends StatelessWidget {
  const ProfileViewBodyUserInfo({super.key, this.prominent = false});

  final bool prominent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPersonalDetailsCubit, UserPersonalDetailsState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final textStyles = AppTextStyles(context);
        final user = getUserData();
        final Color primaryColor = theme.colorScheme.primary;
        final name = '${user.firstName} ${user.lastName}'
            .trim()
            .split(RegExp(r'\s+'))
            .join(' ');
        final avatarSize = prominent ? 96.0 : 72.0;

        final role = user.role == BackendEndpoints.teacherRole
            ? LocaleKeys.teacherRole
            : LocaleKeys.studentRole;

        final nameText = Text(
          name,
          maxLines: prominent ? 2 : 1,
          overflow: TextOverflow.ellipsis,
          style: (prominent ? textStyles.bold20 : textStyles.bold16).copyWith(
            color: theme.colorScheme.onSurface,
            height: 1.2,
          ),
        );

        final roleChip = Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: primaryColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Text(
            role,
            style: textStyles.semiBold12.copyWith(
              color: primaryColor,
              height: 1.2,
            ),
          ),
        );

        final emailText = Text(
          user.email,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textDirection: TextDirection.ltr,
          style: (prominent ? textStyles.regular14 : textStyles.regular13)
              .copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.75,
                ),
              ),
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  padding: EdgeInsets.all(prominent ? 3 : 2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.45),
                      width: 1.5,
                    ),
                  ),
                  child: UserAvatar(profilePicurl: user.profilePicurl),
                ),
                PositionedDirectional(
                  bottom: -2,
                  end: -2,
                  child: UpadateUserProfilePicIconButton(user: user),
                ),
              ],
            ),
            SizedBox(width: prominent ? 20 : 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: prominent
                    ? [
                        nameText,
                        const SizedBox(height: 8),
                        roleChip,
                        const SizedBox(height: 8),
                        emailText,
                      ]
                    : [
                        Row(
                          children: [
                            Flexible(child: nameText),
                            const SizedBox(width: 8),
                            roleChip,
                          ],
                        ),
                        const SizedBox(height: 6),
                        emailText,
                      ],
              ),
            ),
          ],
        );
      },
    );
  }
}
