import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/user_personal_details_cubit/user_personal_details_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.profilePicurl,
  });

  final String profilePicurl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPersonalDetailsCubit, UserPersonalDetailsState>(
      builder: (context, state) => ClipOval(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Skeletonizer(
              enabled: state is UpdatedUserProfilePicLoading,
              child: CustomCachedNetworkImage(
                imageUrl: profilePicurl,
                fit: BoxFit.cover,
              ),
            ),
            if (state is UpdatedUserProfilePicLoading)
              ColoredBox(
                color: Colors.black.withValues(alpha: 0.28),
                child: const Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
