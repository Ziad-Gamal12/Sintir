import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Profile/Domain/Entities/ProfileActionsEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileItemActionLeadingIcon.dart';

class ProfileItemAction extends StatelessWidget {
  const ProfileItemAction({
    super.key,
    required this.profileActionsEntity,
    this.showDivider = true,
  });
  final ProfileActionsEntity profileActionsEntity;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            child: ListTile(
              onTap: () => context.push(profileActionsEntity.routeName),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: ProfileItemActionLeadingIcon(
                profileActionsEntity: profileActionsEntity,
              ),
              title: Text(
                profileActionsEntity.title,
                style: AppTextStyles(
                  context,
                ).semiBold16.copyWith(color: theme.colorScheme.onSurface),
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.outline,
                size: 22,
              ),
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              thickness: 0.6,
              color: theme.dividerColor.withValues(alpha: 0.08),
              indent: 16,
              endIndent: 16,
            ),
        ],
      ),
    );
  }
}
