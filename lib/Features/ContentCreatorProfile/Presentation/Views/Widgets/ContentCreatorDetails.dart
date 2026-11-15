import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/content_creator_courses_cubit/content_creator_courses_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/Widgets/CreatorAvatar.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/Widgets/CreatorNameTitle.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/Widgets/CreatorStats.dart';

class ContentCreatorDetails extends StatefulWidget {
  final Contentcreaterentity contentcreaterentity;

  const ContentCreatorDetails({super.key, required this.contentcreaterentity});

  @override
  State<ContentCreatorDetails> createState() => _ContentCreatorDetailsState();
}

class _ContentCreatorDetailsState extends State<ContentCreatorDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final creator = widget.contentcreaterentity;
    final ThemeData theme = Theme.of(context);

    final subscribersCount = context
        .watch<ContentCreatorCoursesCubit>()
        .getContentCreatorSubscribersCount();

    final coursesCount = context
        .watch<ContentCreatorCoursesCubit>()
        .getContentCreatorCoursesCount();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CreatorAvatar(imageUrl: creator.profileImageUrl),
        const SizedBox(height: 14),
        CreatorNameTitle(name: creator.name, title: creator.title),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Divider(
            height: 1,
            thickness: 1,
            color: theme.dividerColor.withValues(alpha: 0.08),
          ),
        ),
        CreatorStats(
          coursesCount: coursesCount,
          subscribersCount: subscribersCount,
        ),
      ],
    );
  }
}
