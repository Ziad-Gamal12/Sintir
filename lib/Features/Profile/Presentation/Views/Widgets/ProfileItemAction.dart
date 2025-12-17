import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Profile/Domain/Entities/ProfileActionsEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileItemActionLeadingIcon.dart';

class ProfileItemAction extends StatelessWidget {
  const ProfileItemAction({super.key, required this.profileActionsEntity});
  final ProfileActionsEntity profileActionsEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () => context.push(profileActionsEntity.routeName),
            visualDensity: VisualDensity.compact,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: ProfileItemActionLeadingIcon(
              profileActionsEntity: profileActionsEntity,
            ),
            title: Text(
              profileActionsEntity.title,
              style: AppTextStyles(context).semiBold16.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.outline,
              size: 24,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Divider(
            height: 2,
            thickness: 0.5,
            color: theme.dividerColor.withOpacity(0.1),
            indent: 56,
            endIndent: 16,
          ),
        ],
      ),
    );
  }
}
