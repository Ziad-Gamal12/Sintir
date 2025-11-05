import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserDetailsRow.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getUserData();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade100,
          blurRadius: 10,
          spreadRadius: 4,
        ),
      ], color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10)),
      child: UserDetails(user: user),
    );
  }
}
