// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersLoadingGridView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseStudentsCount.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailsSubscribersViewBody extends StatefulWidget {
  const CourseDetailsSubscribersViewBody({
    super.key,
    required this.courseEntity,
  });
  final CourseEntity courseEntity;
  @override
  State<CourseDetailsSubscribersViewBody> createState() =>
      _CourseDetailsSubscribersViewBodyState();
}

class _CourseDetailsSubscribersViewBodyState
    extends State<CourseDetailsSubscribersViewBody> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<SubscriberEntity> _subscribers = [];
  final List<SubscriberEntity> _searchSubscribers = [];
  Timer? _debounce;
  bool isSearching = false;
  bool _normalHasMore = true;
  bool _searchHasMore = true;
  bool _normalPageLoading = false;
  bool _searchPageLoading = false;
  bool _searchReady = false;
  bool _normalInitialLoading = true;
  bool _searchInitialLoading = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CourseSubscribtionsCubit>();

    cubit.getCoursSubscribers(isPaginate: false);

    controller.addListener(_onSearchChanged);

    scrollController.addListener(() {
      if (!mounted) return;
      if (!scrollController.hasClients ||
          scrollController.position.extentAfter > 300) {
        return;
      }
      if (isSearching &&
          _searchReady &&
          _searchHasMore &&
          !_searchPageLoading) {
        _searchPageLoading = true;
        cubit.searchSubscribers(
          keyword: controller.text.trim(),
          isPaginate: true,
        );
      } else if (!isSearching && _normalHasMore && !_normalPageLoading) {
        _normalPageLoading = true;
        cubit.getCoursSubscribers(isPaginate: true);
      }
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    final keyword = controller.text.trim();
    final cubit = context.read<CourseSubscribtionsCubit>();
    cubit.invalidateSubscriberSearch();
    if (keyword.isEmpty) {
      _debounce?.cancel();
      setState(() {
        isSearching = false;
        _searchReady = false;
        _searchInitialLoading = false;
        _searchSubscribers.clear();
      });
      _searchHasMore = true;
      if (scrollController.hasClients) scrollController.jumpTo(0);
      return;
    }
    setState(() {
      isSearching = true;
      _searchReady = false;
      _searchInitialLoading = true;
      _searchSubscribers.clear();
      _searchHasMore = true;
      _searchPageLoading = false;
    });
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (scrollController.hasClients) scrollController.jumpTo(0);
      _searchReady = true;
      cubit.searchSubscribers(keyword: keyword, isPaginate: false);
    });
  }

  @override
  void dispose() {
    controller.removeListener(_onSearchChanged);
    controller.dispose();
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSubscribtionsCubit, CourseSubscribtionsState>(
      listener: (context, state) {
        if (state is GetCourseSubscribersSuccess) {
          _normalInitialLoading = false;
          _normalPageLoading = false;
          if (state.response.isPaginate) {
            _merge(_subscribers, state.response.subscribers);
          } else {
            _subscribers
              ..clear()
              ..addAll(state.response.subscribers);
          }
          _normalHasMore =
              state.response.hasMore && state.response.subscribers.isNotEmpty;
          setState(() {});
        }

        if (state is GetCourseSubscribersFailure) {
          _normalInitialLoading = false;
          _normalPageLoading = false;
          if (_subscribers.isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        }

        if (state is SearchSubscribersSuccess) {
          _searchInitialLoading = false;
          _searchPageLoading = false;
          if (state.response.isPaginate) {
            _merge(_searchSubscribers, state.response.subscribers);
          } else {
            _searchSubscribers
              ..clear()
              ..addAll(state.response.subscribers);
          }
          _searchHasMore =
              state.response.hasMore && state.response.subscribers.isNotEmpty;
          setState(() {});
        }
        if (state is SearchSubscribersFailure) {
          _searchInitialLoading = false;
          _searchPageLoading = false;
          if (_searchSubscribers.isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        }
      },
      builder: (context, state) {
        final list = isSearching ? _searchSubscribers : _subscribers;
        final initialLoading = isSearching
            ? _searchInitialLoading
            : _normalInitialLoading && _subscribers.isEmpty;
        final failure = isSearching
            ? state is SearchSubscribersFailure
            : state is GetCourseSubscribersFailure;
        return LayoutBuilder(
          builder: (context, constraints) {
            final gutter = ContentWidth.gutter(
              constraints.maxWidth,
              ContentWidth.detail,
            );
            final isWide = constraints.maxWidth >= Breakpoints.expanded;
            final search = CustomSearchTextField(controller: controller);
            final count = CourseStudentsCount(
              count: widget.courseEntity.studentsCount,
            );
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                if (isWide)
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(gutter, 24, gutter, 20),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [
                          Expanded(child: search),
                          const SizedBox(width: 24),
                          count,
                        ],
                      ),
                    ),
                  )
                else ...[
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(gutter, 16, gutter, 12),
                    sliver: SliverToBoxAdapter(child: search),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: gutter),
                    sliver: SliverToBoxAdapter(child: count),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ],
                if (initialLoading)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: gutter),
                    sliver: const CourseDetailsSubscribersLoadingGridView(),
                  )
                else if (failure && list.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomErrorWidget(
                            errormessage: state is GetCourseSubscribersFailure
                                ? state.errMessage
                                : (state as SearchSubscribersFailure)
                                      .errMessage,
                          ),
                          TextButton(
                            onPressed: () {
                              if (isSearching) {
                                setState(() => _searchInitialLoading = true);
                                context
                                    .read<CourseSubscribtionsCubit>()
                                    .searchSubscribers(
                                      keyword: controller.text.trim(),
                                      isPaginate: false,
                                    );
                              } else {
                                setState(() => _normalInitialLoading = true);
                                context
                                    .read<CourseSubscribtionsCubit>()
                                    .getCoursSubscribers(isPaginate: false);
                              }
                            },
                            child: Text(LocaleKeys.reportRetry),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (list.isNotEmpty)
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(gutter, 0, gutter, 16),
                    sliver: CourseDetailsSubscribersGridView(
                      subscribers: list,
                      courseEntity: widget.courseEntity,
                    ),
                  )
                else if (state is! GetCourseSubscribersLoading &&
                    state is! SearchSubscribersLoading)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CustomEmptyWidget(
                        text: LocaleKeys.noSubscribersInCourse,
                      ),
                    ),
                  ),
                if (list.isNotEmpty &&
                    (isSearching ? _searchPageLoading : _normalPageLoading))
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  void _merge(List<SubscriberEntity> target, List<SubscriberEntity> incoming) {
    final ids = target.map((item) => item.id).toSet();
    for (final subscriber in incoming) {
      if (ids.add(subscriber.id)) target.add(subscriber);
    }
  }
}
