// SubscriberContactChipsRow.dart
import 'package:flutter/material.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/CustomSubscriberMetaInfoCard.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberContactChipsRow extends StatelessWidget {
  const SubscriberContactChipsRow({
    super.key,
    required this.phoneNum,
    required this.address,
  });
  final String phoneNum, address;

  static const double _stackBelowWidth = 290;

  @override
  Widget build(BuildContext context) {
    final phone = phoneNum.trim();
    final location = address.trim();
    final warning = ResultsTokens.of(Theme.of(context)).warning;

    return LayoutBuilder(
      builder: (context, box) {
        final stacked =
            box.maxWidth < _stackBelowWidth ||
            MediaQuery.textScalerOf(context).scale(1) > 1.3;

        final phoneTile = CustomSubscriberMetaInfoCard(
          text: phone.isEmpty ? LocaleKeys.subscriberPhoneFallback : phone,
          icon: Icons.phone_rounded,
          textDirection: phone.isEmpty ? null : TextDirection.ltr,
          isPlaceholder: phone.isEmpty,
        );
        final addressTile = CustomSubscriberMetaInfoCard(
          text: location.isEmpty
              ? LocaleKeys.subscriberAddressFallback
              : location,
          icon: Icons.location_on_rounded,
          accent: warning,
          isPlaceholder: location.isEmpty,
          maxLines: stacked ? 2 : 1,
        );

        if (stacked) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [phoneTile, const SizedBox(height: 8), addressTile],
          );
        }
        return Row(
          children: [
            Expanded(child: phoneTile),
            const SizedBox(width: 10),
            Expanded(child: addressTile),
          ],
        );
      },
    );
  }
}
