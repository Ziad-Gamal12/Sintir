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
    return BlocSelector<UserPersonalDetailsCubit, UserPersonalDetailsState,
        bool>(
      selector: (state) {
        return state is UpdatedUserProfilePicLoading;
      },
      builder: (context, isLoading) => Skeletonizer(
          enabled: isLoading,
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 30,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CustomCachedNetworkImage(imageUrl: profilePicurl)),
          )),
    );
  }
}
