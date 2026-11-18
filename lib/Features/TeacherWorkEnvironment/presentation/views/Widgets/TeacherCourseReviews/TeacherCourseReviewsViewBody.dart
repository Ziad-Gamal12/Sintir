// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherCourseReviews/TeacherReviewsFilterBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherCourseReviews/TeacherReviewsOverview.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherCourseReviews/TeacherReviewsSliverList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_course_reviews_cubit/teacher_course_reviews_cubit.dart';
import 'package:sintir/constant.dart';

class TeacherCourseReviewsViewBody extends StatefulWidget {
  const TeacherCourseReviewsViewBody({super.key});

  @override
  State<TeacherCourseReviewsViewBody> createState() =>
      _TeacherCourseReviewsViewBodyState();
}

class _TeacherCourseReviewsViewBodyState
    extends State<TeacherCourseReviewsViewBody> {
  static const double _loadMoreThreshold = 400;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _overviewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_maybeLoadMore);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _maybeLoadMore() {
    if (!mounted || !_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.maxScrollExtent - position.pixels > _loadMoreThreshold) {
      return;
    }
    context.read<TeacherCourseReviewsCubit>().loadMore();
  }

  void _checkAfterLayout(
    BuildContext context,
    TeacherCourseReviewsState state,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeLoadMore());
  }

  void _keepListInView(
    BuildContext context,
    TeacherCourseReviewsState state,
  ) {
    if (!_scrollController.hasClients) return;
    final overview = _overviewKey.currentContext?.findRenderObject();
    final listTop = overview is RenderBox && overview.hasSize
        ? overview.size.height
        : 0.0;
    if (_scrollController.offset > listTop) {
      _scrollController.jumpTo(listTop);
    }
  }

  Future<void> _refresh() async {
    final message = await context.read<TeacherCourseReviewsCubit>().refresh();
    if (!mounted || message == null) return;
    CustomSnackBar.show(context, message: message, type: SnackType.error);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TeacherCourseReviewsCubit, TeacherCourseReviewsState>(
          listenWhen: (previous, current) => previous.query != current.query,
          listener: _keepListInView,
        ),
        BlocListener<TeacherCourseReviewsCubit, TeacherCourseReviewsState>(
          listenWhen: (previous, current) =>
              previous.reviews.length != current.reviews.length ||
              previous.hasMore != current.hasMore,
          listener: _checkAfterLayout,
        ),
      ],
      child: RefreshIndicator(
        color: KMainColor,
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                key: _overviewKey,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: const TeacherReviewsOverview(),
              ),
            ),
            const TeacherReviewsFilterBar(),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: TeacherReviewsSliverList(),
            ),
          ],
        ),
      ),
    );
  }
}
