import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFedBack_Widgets/CourseFedBacksListView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFedBack_Widgets/CoursefedbackviewBodyActionButton.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class Coursefedbackviewbody extends StatefulWidget {
  const Coursefedbackviewbody({super.key, required this.requirmentsEntity});
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  @override
  State<Coursefedbackviewbody> createState() => _CoursefedbackviewbodyState();
}

class _CoursefedbackviewbodyState extends State<Coursefedbackviewbody> {
  late TextEditingController controller;
  late GlobalKey<FormState> formKey;
  late CoursefeedbackItemEntity coursefedbackItemEntity;
  late ScrollController scrollController;
  bool hasMore = true;
  List<CoursefeedbackItemEntity> feedBacks = [];
  @override
  void initState() {
    controller = TextEditingController();
    scrollController = ScrollController();
    formKey = GlobalKey<FormState>();
    coursefedbackItemEntity = CoursefeedbackItemEntity(
        datePosted: DateTime.now(),
        fedBack: "",
        name: getUserData().fullName,
        userImage: getUserData().profilePicurl,
        uid: getUserData().uid);
    CourseFeedBacksCubit cubit = context.read<CourseFeedBacksCubit>();
    cubit.getCourseFeedBacks(
        courseId: widget.requirmentsEntity.course.id, isPaginate: false);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          hasMore &&
          cubit.state is! CourseFeedBacksGetFeedBackLoading) {
        cubit.getCourseFeedBacks(
            courseId: widget.requirmentsEntity.course.id, isPaginate: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseFeedBacksCubit, CourseFeedBacksState>(
      listener: (context, state) {
        if (state is CourseFeedBacksAddFeedBackSuccess) {
          controller.clear();
          CustomSnackBar.show(
            context,
            message: LocaleKeys.commentPostedSuccessfully,
            type: SnackType.success,
          );
        } else if (state is CourseFeedBacksAddFeedBackFailure) {
          CustomSnackBar.show(
            context,
            message: state.errMessage,
            type: SnackType.error,
          );
        } else if (state is CourseFeedBacksGetFeedBackSuccess) {
          if (state.response.isPaginate) {
            feedBacks.addAll(state.response.feedBacks);
          } else {
            feedBacks = state.response.feedBacks;
          }
          hasMore = state.response.hasMore;
          setState(() {});
        }
      },
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          child: Stack(
            children: [
              Coursefedbackslistview(
                courseFedBacks: feedBacks,
                scrollController: scrollController,
              ),
              Positioned(
                  bottom: 25,
                  left: 0,
                  right: 0,
                  child: CoursefedbackviewBodyActionButton(
                      controller: controller,
                      requirmentsEntity: widget.requirmentsEntity,
                      formKey: formKey,
                      coursefedbackItemEntity: coursefedbackItemEntity))
            ],
          ),
        ),
      ),
    );
  }
}
