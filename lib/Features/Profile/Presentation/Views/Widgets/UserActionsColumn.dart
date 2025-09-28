import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomSettingsIcon.dart';
import 'package:sintir/Core/widgets/CustomSupportWidget.dart';

class UserActionsColumn extends StatelessWidget {
  const UserActionsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Customsettingsicon(),
        SizedBox(height: 20),
        Customsupportwidget(),
      ],
    );
  }
}
