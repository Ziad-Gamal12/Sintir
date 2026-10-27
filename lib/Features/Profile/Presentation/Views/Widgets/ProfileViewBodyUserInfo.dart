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
        final role = user.role == BackendEndpoints.teacherRole
            ? LocaleKeys.teacherRole
            : LocaleKeys.studentRole;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: isDark
                ? const LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [Color(0xff181C24), Color(0xff1E2430)],
                  )
                : null,
            color: isDark ? null : theme.cardColor,
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.06),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color(0xff3FC4FF), width: 1.5),
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
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 180),
                          child: Text(
                            '${user.firstName} ${user.lastName}'.trim(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles(context).bold16.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xff3FC4FF).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xff3FC4FF)
                                  .withValues(alpha: 0.35),
                            ),
                          ),
                          child: Text(
                            role,
                            style: AppTextStyles(context).semiBold12.copyWith(
                                  color: const Color(0xff3FC4FF),
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
                      style: AppTextStyles(context).regular13.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
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
