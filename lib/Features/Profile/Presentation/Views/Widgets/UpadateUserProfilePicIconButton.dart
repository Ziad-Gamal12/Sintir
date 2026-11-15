import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/user_personal_details_cubit/user_personal_details_cubit.dart';

class UpadateUserProfilePicIconButton extends StatelessWidget {
  const UpadateUserProfilePicIconButton({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<UserPersonalDetailsCubit, UserPersonalDetailsState>(
      builder: (context, state) {
        final isLoading = state is UpdatedUserProfilePicLoading;
        return Material(
          color: theme.colorScheme.surface,
          shape: CircleBorder(
            side: BorderSide(color: theme.cardColor, width: 2),
          ),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: isLoading
                ? null
                : () => context
                      .read<UserPersonalDetailsCubit>()
                      .updatedUserProfilePic(uid: user.uid),
            child: SizedBox(
              width: 28,
              height: 28,
              child: Center(
                child: isLoading
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 1.8),
                      )
                    : Icon(
                        Icons.camera_alt_rounded,
                        color: theme.iconTheme.color,
                        size: 15,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
