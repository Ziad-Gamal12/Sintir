// user_info_section_personal_details_header.dart
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/PersonalDetailsHeaderTitleRow.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserInfoSectionPersonalDetails.dart';

class UserInfoSectionPersonalDetailsHeader extends StatelessWidget {
  const UserInfoSectionPersonalDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionWidget(
          initiallyExpanded: false,
          titleBuilder: (_, __, bool isExpanded, toggleFunction) {
            return HeaderTitleRow(
              isExpanded: isExpanded,
              onTap: () => toggleFunction(animated: true),
            );
          },
          content: const UserInfoSectionPersonalDetails(),
        ),
      ),
    );
  }
}
