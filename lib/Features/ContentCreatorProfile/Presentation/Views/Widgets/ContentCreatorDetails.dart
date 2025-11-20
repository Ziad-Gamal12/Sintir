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
      duration: const Duration(milliseconds: 600),
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

    final subscribersCount = context
        .watch<ContentCreatorCoursesCubit>()
        .getContentCreatorSubscribersCount();

    final coursesCount = context
        .watch<ContentCreatorCoursesCubit>()
        .getContentCreatorCoursesCount();

    return ScaleTransition(
      scale: CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            CreatorAvatar(imageUrl: creator.profileImageUrl),
            const SizedBox(height: 18),
            CreatorNameTitle(
              name: creator.name,
              title: creator.title,
            ),
            const SizedBox(height: 20),
            CreatorStats(
              coursesCount: coursesCount,
              subscribersCount: subscribersCount,
            ),
            const SizedBox(height: 20),
            Container(
              height: 4,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff7F5AFF),
                    Color(0xff5F9BFF),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
