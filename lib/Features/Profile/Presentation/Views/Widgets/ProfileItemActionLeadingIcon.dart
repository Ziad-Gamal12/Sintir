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
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: profileActionsEntity.color == null
              ? Colors.grey.shade50
              : profileActionsEntity.color?.withOpacity(.1),
        ),
        child: Icon(profileActionsEntity.icon,
            color: profileActionsEntity.color ?? Colors.black, size: 25));
  }
}
