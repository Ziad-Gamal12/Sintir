// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersLoadingGridView.dart';
import 'package:sintir/constant.dart';

class CourseDetailsSubscribersViewBody extends StatefulWidget {
  const CourseDetailsSubscribersViewBody({
    super.key,
  });

  @override
  State<CourseDetailsSubscribersViewBody> createState() =>
      _CourseDetailsSubscribersViewBodyState();
}

class _CourseDetailsSubscribersViewBodyState
    extends State<CourseDetailsSubscribersViewBody>
    with AutomaticKeepAliveClientMixin {
  late ScrollController scrollController;
  final TextEditingController controller = TextEditingController();
  final List<Subscriberentity> _subscribers = [];
  bool hasMore = true;
  VoidCallback? _scrollListener;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    final cubit = context.read<CourseSubscribtionsCubit>();
    cubit.getCoursSubscribers(isPaginate: false);
    _scrollListener = () {
      if (!mounted) return;
      if (_shouldFetchMore(cubit)) {
        cubit.getCoursSubscribers(isPaginate: true);
      }
    };
    scrollController.addListener(_scrollListener!);
  }

  bool _shouldFetchMore(CourseSubscribtionsCubit cubit) {
    return scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! GetCourseSubscribersLoading;
  }

  @override
  void dispose() {
    if (_scrollListener != null) {
      scrollController.removeListener(_scrollListener!);
    }
    controller.dispose();
    scrollController.dispose();
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
        return ListView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          children: [
            const SizedBox(height: 20),
            CustomSearchTextField(
              controller: controller,
              onSearchChanged: () {},
            ),
            const SizedBox(height: 20),
            if (state is GetCourseSubscribersLoading && _subscribers.isEmpty)
              const CourseDetailsSubscribersLoadingGridView()
            else if (_subscribers.isNotEmpty)
              CourseDetailsSubscribersGridView(
                subscribers: _subscribers,
              )
            else if (state is! GetCourseSubscribersLoading)
              CustomEmptyWidget(
                text: "لا يوجد اشخاص مشتركين في هذا الدورة",
              ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
