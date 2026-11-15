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
  const ProfileViewBodyUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPersonalDetailsCubit, UserPersonalDetailsState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final user = getUserData();
        final isDark = theme.brightness == Brightness.dark;
        final Color primaryColor = theme.colorScheme.primary;

        final role = user.role == BackendEndpoints.teacherRole
            ? LocaleKeys.teacherRole
            : LocaleKeys.studentRole;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.08),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. صورة المستخدم مع زر التحديث
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    padding: const EdgeInsets.all(2.5),
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
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${user.firstName} ${user.lastName}'.trim(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles(context).bold16.copyWith(
                              color: theme.colorScheme.onSurface,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
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
                            style: AppTextStyles(context).semiBold12.copyWith(
                              color: primaryColor,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      user.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                      style: AppTextStyles(context).regular13.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.75,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
