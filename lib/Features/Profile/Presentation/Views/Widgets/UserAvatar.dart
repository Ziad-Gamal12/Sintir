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
      builder: (context, state) => Skeletonizer(
          enabled: state is UpdatedUserProfilePicLoading,
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CustomCachedNetworkImage(
                    imageUrl: profilePicurl, fit: BoxFit.cover)),
          )),
    );
  }
}
