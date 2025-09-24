// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridView.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsSubscribersPageViewItem extends StatefulWidget {
  const CourseDetailsSubscribersPageViewItem({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<CourseDetailsSubscribersPageViewItem> createState() =>
      _CourseDetailsSubscribersPageViewItemState();
}

class _CourseDetailsSubscribersPageViewItemState
    extends State<CourseDetailsSubscribersPageViewItem> {
  final TextEditingController controller = TextEditingController();
  final List<Subscriberentity> _subscribers = [];
  bool hasMore = true;

  @override
  void initState() {
    super.initState();

    context
        .read<CourseSubscribtionsCubit>()
        .getCoursSubscribers(isPaginate: false);

    widget.scrollController.addListener(() {
      final cubit = context.read<CourseSubscribtionsCubit>();
      if (_shouldFetchMore(cubit)) {
        cubit.getCoursSubscribers(isPaginate: true);
      }
    });
  }

  bool _shouldFetchMore(CourseSubscribtionsCubit cubit) {
    return widget.scrollController.position.pixels >=
            widget.scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! GetCourseSubscribersLoading;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSubscribtionsCubit, CourseSubscribtionsState>(
      listener: (context, state) {
        if (state is GetCourseSubscribersSuccess) {
          if (state.response.isPaginate) {
            _subscribers.addAll(state.response.subscribers);
          } else {
            _subscribers.clear();
            _subscribers.addAll(state.response.subscribers);
          }
          hasMore = state.response.hasMore;
          setState(() {});
        }
      },
      builder: (context, state) {
        if (state is GetCourseSubscribersFailure) {
          return Center(
            child: CustomErrorWidget(errormessage: state.errMessage),
          );
        }

        return Skeletonizer(
          enabled: state is GetCourseSubscribersLoading && _subscribers.isEmpty,
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomSearchTextField(
                controller: controller,
                onSearchChanged: () {},
              ),
              const SizedBox(height: 20),
              if (_subscribers.isNotEmpty)
                CourseDetailsSubscribersGridView(
                  subscribers: _subscribers,
                )
              else if (state is! GetCourseSubscribersLoading)
                const CustomEmptyWidget()
            ],
          ),
        );
      },
    );
  }
}
