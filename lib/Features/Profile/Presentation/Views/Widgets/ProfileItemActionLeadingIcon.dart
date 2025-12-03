import 'package:flutter/material.dart';
import 'package:sintir/Features/Profile/Domain/Entities/ProfileActionsEntity.dart';

class ProfileItemActionLeadingIcon extends StatelessWidget {
  const ProfileItemActionLeadingIcon({
    super.key,
    required this.profileActionsEntity,
  });

  final ProfileActionsEntity profileActionsEntity;

  @override
  Widget build(BuildContext context) {
    final color = profileActionsEntity.getColor(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.08), // subtle background for both themes
      ),
      child: Icon(
        profileActionsEntity.icon,
        color: color,
        size: 24,
      ),
    );
  }
}
