import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/user_personal_details_cubit/user_personal_details_cubit.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UpadateUserProfilePicIconButton.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserAvatar.dart';

class ProfileViewBodyUserInfo extends StatefulWidget {
  const ProfileViewBodyUserInfo({super.key});

  @override
  State<ProfileViewBodyUserInfo> createState() =>
      _ProfileViewBodyUserInfoState();
}

class _ProfileViewBodyUserInfoState extends State<ProfileViewBodyUserInfo> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPersonalDetailsCubit, UserPersonalDetailsState>(
      builder: (context, state) {
        UserEntity user = getUserData();
        return ListTile(
          minVerticalPadding: 0,
          minLeadingWidth: 60,
          leading: UserAvatar(profilePicurl: user.profilePicurl),
          title: Text(
            "${user.firstName} ${user.lastName}",
            style: AppTextStyles(context).bold16.copyWith(color: Colors.black),
          ),
          subtitle: Text(
            user.email,
            style: AppTextStyles(context).light14.copyWith(color: Colors.black),
          ),
          trailing: UpadateUserProfilePicIconButton(user: user),
        );
      },
    );
  }
}
