import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReviewsSectionWidgets/CourseDetailsSubscriberLoadingReviewsListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReviewsSectionWidgets/CourseDetailsSubscriberReviewsListView.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailsSubscribersReviewsViewBody extends StatefulWidget {
  const CourseDetailsSubscribersReviewsViewBody({
    super.key,
    required this.courseId,
  });

  final String courseId;

  @override
  State<CourseDetailsSubscribersReviewsViewBody> createState() =>
      _CourseDetailsSubscribersReviewsViewBodyState();
}

class _CourseDetailsSubscribersReviewsViewBodyState
    extends State<CourseDetailsSubscribersReviewsViewBody>
    with AutomaticKeepAliveClientMixin {
  List<CoursefeedbackItemEntity> feedbacks = [];

  bool hasMore = true;

  VoidCallback? _scrollListener;
  late ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    final cubit = context.read<CourseFeedBacksCubit>();

    cubit.getCourseFeedBacks(courseId: widget.courseId, isPaginate: false);

    _scrollListener = () {
      if (_shouldFetchMore(cubit)) {
        cubit.getCourseFeedBacks(courseId: widget.courseId, isPaginate: true);
      }
    };

    scrollController.addListener(_scrollListener!);
  }

  bool _shouldFetchMore(CourseFeedBacksCubit cubit) {
    return scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! CourseFeedBacksGetFeedBackLoading;
  }

  @override
  void dispose() {
    if (_scrollListener != null) {
      scrollController.removeListener(_scrollListener!);
    }
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<CourseFeedBacksCubit, CourseFeedBacksState>(
      listener: (context, state) {
        if (state is CourseFeedBacksGetFeedBackSuccess) {
          if (state.response.isPaginate) {
            setState(() {
              feedbacks.addAll(state.response.feedBacks);
            });
          } else {
            setState(() {
              feedbacks = state.response.feedBacks;
            });
          }
          hasMore = state.response.hasMore;
        }
      },
      builder: (context, state) {
        if (state is CourseFeedBacksGetFeedBackFailure) {
          return Center(
            child: CustomErrorWidget(errormessage: state.errMessage),
          );
        } else if (state is CourseFeedBacksGetFeedBackLoading) {
          return const CourseDetailsSubscriberLoadingReviewsListView();
        } else if (feedbacks.isNotEmpty) {
          return CourseDetailsSubscriberReviewsListView(
              scrollController: scrollController, reviews: feedbacks);
        } else if (state is! CourseFeedBacksGetFeedBackLoading) {
          return CustomEmptyWidget(
            text: LocaleKeys.emptyContent,
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
                child: CircularProgressIndicator(
              color: KMainColor,
            )),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
