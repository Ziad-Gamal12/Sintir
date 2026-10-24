import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/CustomSubscriberMetaInfoCard.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberContactChipsRow extends StatelessWidget {
  const SubscriberContactChipsRow(
      {super.key, required this.phoneNum, required this.address});
  final String phoneNum, address;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomSubscriberMetaInfoCard(
            text: phoneNum.trim().isEmpty
                ? LocaleKeys.subscriberPhoneFallback
                : phoneNum.trim(),
            icon: Icons.phone,
            textDirection: phoneNum.trim().isEmpty ? null : TextDirection.ltr,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: CustomSubscriberMetaInfoCard(
            text: address.trim().isEmpty
                ? LocaleKeys.subscriberAddressFallback
                : address.trim(),
            icon: Icons.location_on_outlined,
            iconColor: const Color(0xFFFF8C1A),
          ),
        ),
      ],
    );
  }
}
