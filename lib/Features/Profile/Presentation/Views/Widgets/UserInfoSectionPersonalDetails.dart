import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/CustomPersonalDetailsRowItem.dart';

class UserInfoSectionPersonalDetails extends StatelessWidget {
  const UserInfoSectionPersonalDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomPersonalDetailsRowItem(
            icon: FontAwesomeIcons.idCardClip,
            text: getUserData().uid,
          ),
          CustomPersonalDetailsRowItem(
            icon: Icons.email,
            text: getUserData().email,
          ),
          CustomPersonalDetailsRowItem(
            icon: Icons.phone,
            text: getUserData().phoneNumber,
          ),
          CustomPersonalDetailsRowItem(
            icon: Icons.location_on,
            text: getUserData().address,
          ),
          CustomPersonalDetailsRowItem(
            icon: Icons.date_range,
            text: getUserData().joinedDate,
          ),
        ],
      ),
    );
  }
}
