import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberContactChipsRow.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberIdCopyContainer.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberJoinedDateRow.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberProfileHeader.dart';

class CustomSubscriberDetailsCard extends StatelessWidget {
  const CustomSubscriberDetailsCard(
      {super.key, required this.subscriberentity});
  final SubscriberEntity subscriberentity;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: theme.brightness == Brightness.light ? 1 : 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: .45)),
      ),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubscriberProfileHeader(
                subscriberEntity: subscriberentity,
              ),
              Divider(
                  height: 20,
                  thickness: 1,
                  color: theme.dividerColor.withValues(alpha: .55)),
              SubscriberContactChipsRow(
                  phoneNum: subscriberentity.phone,
                  address: subscriberentity.address),
              SizedBox(
                height: 10,
              ),
              if (subscriberentity.joinedDate != null)
                SubscriberJoinedDateRow(
                  joinedDate: subscriberentity.joinedDate!,
                ),
              SizedBox(
                height: 10,
              ),
              SubscriberIdCopyContainer(
                subscriberID: subscriberentity.id,
              )
            ],
          )),
    );
  }
}
