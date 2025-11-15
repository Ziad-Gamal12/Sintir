import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/LogOutDialog.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileItemActionsButtons.dart';
import 'package:sintir/constant.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(
          horizontal: KHorizontalPadding, vertical: KVerticalPadding),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: ProfileItemActionsButtons(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          SliverToBoxAdapter(
            child: Custombutton(
              text: "تسجيل الخروج",
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => const LogoutDialog(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
