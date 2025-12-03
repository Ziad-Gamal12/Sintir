import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/user_personal_details_cubit/user_personal_details_cubit.dart';

class UpadateUserProfilePicIconButton extends StatelessWidget {
  const UpadateUserProfilePicIconButton({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        context
            .read<UserPersonalDetailsCubit>()
            .updatedUserProfilePic(uid: user.uid);
      },
      child: CircleAvatar(
        backgroundColor: theme.cardColor,
        child: Icon(
          Icons.add_a_photo,
          color: theme.iconTheme.color,
          size: 20,
        ),
      ),
    );
  }
}
