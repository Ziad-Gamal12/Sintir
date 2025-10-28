import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class CustomdrawerUserListTile extends StatelessWidget {
  const CustomdrawerUserListTile({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(45),
          child: CustomCachedNetworkImage(
            imageUrl: user.profilePicurl,
          ),
        ),
      ),
      title: Text(
        user.firstName,
        style: AppTextStyles(context).semiBold16,
      ),
      subtitle: Text(
        user.email,
        style: AppTextStyles(context).regular13,
      ),
    );
  }
}
