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

    return InkWell(
      onTap: () {
        GoRouter.of(context).push(profileActionsEntity.routeName);
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        leading: ProfileItemActionLeadingIcon(
            profileActionsEntity: profileActionsEntity),
        title: Text(
          profileActionsEntity.title,
          style: AppTextStyles(context)
              .semiBold16
              .copyWith(color: theme.textTheme.bodyLarge?.color),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: theme.iconTheme.color,
          size: 20,
        ),
      ),
    );
  }
}
