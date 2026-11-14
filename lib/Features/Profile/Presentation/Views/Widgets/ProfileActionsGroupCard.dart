import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Profile/Domain/Entities/ProfileActionsEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileItemAction.dart';

class ProfileActionsGroupCard extends StatelessWidget {
  const ProfileActionsGroupCard({
    super.key,
    required this.sectionTitle,
    required this.items,
    this.topSpacing = 0,
  });

  final String sectionTitle;
  final List<ProfileActionsEntity> items;
  final double topSpacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(top: topSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 10),
            child: Text(
              sectionTitle,
              textAlign: TextAlign.start,
              style: AppTextStyles(
                context,
              ).semiBold14.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: theme.cardColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var index = 0; index < items.length; index++)
                  ProfileItemAction(
                    profileActionsEntity: items[index],
                    showDivider: index < items.length - 1,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
