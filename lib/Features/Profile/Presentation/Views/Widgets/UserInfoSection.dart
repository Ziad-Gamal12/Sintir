import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserActionsColumn.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserDetailsRow.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getUserData();

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: UserDetails(user: user)),
              const UserActionsColumn(),
            ],
          ),
        ),
      ),
    );
  }
}
