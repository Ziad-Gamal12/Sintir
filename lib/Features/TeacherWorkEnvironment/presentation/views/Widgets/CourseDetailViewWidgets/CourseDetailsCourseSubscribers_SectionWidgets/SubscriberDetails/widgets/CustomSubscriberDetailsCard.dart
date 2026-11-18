import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberContactChipsRow.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberIdCopyContainer.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberJoinedDateRow.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberProfileHeader.dart';

class CustomSubscriberDetailsCard extends StatelessWidget {
  const CustomSubscriberDetailsCard({
    super.key,
    required this.subscriberentity,
  });
  final SubscriberEntity subscriberentity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: ResultsTokens.of(theme).cardDecoration(theme, radius: 20),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubscriberProfileHeader(subscriberEntity: subscriberentity),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
              child: Divider(height: 1, color: ResultsTokens.of(theme).border),
            ),
            SubscriberContactChipsRow(
              phoneNum: subscriberentity.phone,
              address: subscriberentity.address,
            ),
            if (subscriberentity.joinedDate != null) ...[
              const SizedBox(height: 12),
              SubscriberJoinedDateRow(joinedDate: subscriberentity.joinedDate!),
            ],
            const SizedBox(height: 12),
            SubscriberIdCopyContainer(subscriberID: subscriberentity.id),
          ],
        ),
      ),
    );
  }
}
