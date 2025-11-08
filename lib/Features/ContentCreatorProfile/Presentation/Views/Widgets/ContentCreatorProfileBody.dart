import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/content_creator_courses_cubit/content_creator_courses_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/Widgets/ContentCreatorCoursesGrid.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/Widgets/ContentCreatorCoursesHeader.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/Widgets/ContentCreatorDetails.dart';
import 'package:sintir/constant.dart';

class ContentCreatorProfileBody extends StatefulWidget {
  const ContentCreatorProfileBody(
      {super.key, required this.contentcreaterentity});
  final Contentcreaterentity contentcreaterentity;

  @override
  State<ContentCreatorProfileBody> createState() =>
      _ContentCreatorProfileBodyState();
}

class _ContentCreatorProfileBodyState extends State<ContentCreatorProfileBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ContentCreatorCoursesCubit>().getContentCreatorCourses(
            userId: widget.contentcreaterentity.id,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KHorizontalPadding,
        vertical: KVerticalPadding,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ContentCreatorDetails(
                contentcreaterentity: widget.contentcreaterentity),
          ),
          const SliverToBoxAdapter(
            child: ContentCreatorCoursesHeader(),
          ),
          const ContentCreatorCoursesGrid()
        ],
      ),
    );
  }
}
