import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/CustomUserInfoItem.dart';
import 'package:sintir/locale_keys.dart';

class UserContactInfo extends StatelessWidget {
  final UserEntity user;

  const UserContactInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Text(
              LocaleKeys.profileContact,
              style: styles.semiBold20.copyWith(color: Colors.black),
            ),

            const SizedBox(height: 16),

            // Email
            CustomUserInfoItem(
              icon: FontAwesomeIcons.solidEnvelope,
              title: LocaleKeys.profileEmail,
              value: user.email,
            ),

            const SizedBox(height: 8),

            // Phone Number
            CustomUserInfoItem(
              icon: FontAwesomeIcons.phone,
              title: LocaleKeys.phoneNumber,
              value: user.phoneNumber,
            ),

            const SizedBox(height: 8),

            // Address
            CustomUserInfoItem(
              icon: FontAwesomeIcons.locationDot,
              title: LocaleKeys.profileAddress,
              value: user.address,
            ),
          ],
        ),
      ),
    );
  }
}
