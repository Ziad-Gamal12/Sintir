// ignore_for_file: must_be_immutable, file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersLoadingGridView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseStudentsCount.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailsSubscribersViewBody extends StatefulWidget {
  const CourseDetailsSubscribersViewBody(
      {super.key, required this.courseEntity});
  final CourseEntity courseEntity;
  @override
  State<CourseDetailsSubscribersViewBody> createState() =>
      _CourseDetailsSubscribersViewBodyState();
}

class _CourseDetailsSubscribersViewBodyState
    extends State<CourseDetailsSubscribersViewBody>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController controller = TextEditingController();
  final List<SubscriberEntity> _subscribers = [];
  final List<SubscriberEntity> _searchSubscribers = [];

  late ScrollController scrollController;
  Timer? _debounce;

  bool hasMore = true;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    final cubit = context.read<CourseSubscribtionsCubit>();

    cubit.getCoursSubscribers(isPaginate: false);

    controller.addListener(_onSearchChanged);

    scrollController.addListener(() {
      if (!mounted) return;

      if (_shouldPaginate(cubit)) {
        if (isSearching) {
          cubit.searchSubscribers(
            keyword: controller.text.trim(),
            isPaginate: true,
          );
        } else {
          cubit.getCoursSubscribers(isPaginate: true);
        }
      }
    });
  }

  bool _shouldPaginate(CourseSubscribtionsCubit cubit) {
    return scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! GetCourseSubscribersLoading &&
        cubit.state is! SearchSubscribersLoading;
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final keyword = controller.text.trim();
      final cubit = context.read<CourseSubscribtionsCubit>();

      final searching = keyword.isNotEmpty;
      if (searching != isSearching) {
        setState(() {
          isSearching = searching;
        });
      }

      if (searching) {
        cubit.searchSubscribers(keyword: keyword, isPaginate: false);
      }
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
    super.build(context);

    return BlocConsumer<CourseSubscribtionsCubit, CourseSubscribtionsState>(
      listener: (context, state) {
        if (state is GetCourseSubscribersSuccess) {
          if (state.response.isPaginate) {
            _subscribers.addAll(state.response.subscribers);
          } else {
            _subscribers
              ..clear()
              ..addAll(state.response.subscribers);
          }
          hasMore = state.response.hasMore;
          setState(() {});
        }

        if (state is SearchSubscribersSuccess) {
          if (state.response.isPaginate) {
            _searchSubscribers.addAll(state.response.subscribers);
          } else {
            _searchSubscribers
              ..clear()
              ..addAll(state.response.subscribers);
          }
          hasMore = state.response.hasMore;
          setState(() {});
        }
      },
      builder: (context, state) {
        final list = isSearching ? _searchSubscribers : _subscribers;

        return ListView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding,
            vertical: KVerticalPadding,
          ),
          children: [
            CustomSearchTextField(controller: controller),
            const SizedBox(height: 20),
            CourseStudentsCount(count: widget.courseEntity.studentsCount),
            const SizedBox(height: 20),
            if (state is GetCourseSubscribersLoading && _subscribers.isEmpty)
              const CourseDetailsSubscribersLoadingGridView()
            else if (list.isNotEmpty)
              CourseDetailsSubscribersGridView(
                subscribers: list,
                courseEntity: widget.courseEntity,
              )
            else if (state is! GetCourseSubscribersLoading &&
                state is! SearchSubscribersLoading)
              CustomEmptyWidget(
                text: LocaleKeys.noSubscribersInCourse,
              )
            else if (state is SearchSubscribersLoading &&
                isSearching &&
                _searchSubscribers.isEmpty)
              const CourseDetailsSubscribersLoadingGridView(),
            Visibility(
                visible: (state is SearchSubscribersLoading &&
                        state.isPaginate) ||
                    (state is GetCourseSubscribersLoading && state.isPaginate),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: KMainColor,
                  ),
                ))
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
