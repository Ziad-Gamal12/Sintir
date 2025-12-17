import 'package:flutter/material.dart';
import 'package:sintir/Features/Profile/Domain/Entities/ProfileActionsEntity.dart';

class ProfileItemActionLeadingIcon extends StatelessWidget {
  const ProfileItemActionLeadingIcon({
    super.key,
    required this.profileActionsEntity,
    this.size = 22.0,
  });

  final ProfileActionsEntity profileActionsEntity;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = profileActionsEntity.getColor(context);

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.1),
      ),
      child: Center(
        child: Icon(
          profileActionsEntity.icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
