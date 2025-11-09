import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberAverageScoreCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberHighestScoreCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberLowestScoreCard.dart';

class SubscriberResultsAnalysisCard extends StatefulWidget {
  const SubscriberResultsAnalysisCard({
    super.key,
  });

  @override
  State<SubscriberResultsAnalysisCard> createState() =>
      _SubscriberResultsAnalysisCardState();
}

class _SubscriberResultsAnalysisCardState
    extends State<SubscriberResultsAnalysisCard> {
  @override
  Widget build(BuildContext context) {
    return const CustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SubscriberHighestScoreCard(),
          SizedBox(width: 10),
          SubscriberAverageScoreCard(),
          SizedBox(width: 10),
          SubscriberLowestScoreCard()
        ],
      ),
    );
  }
}
