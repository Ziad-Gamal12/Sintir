import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Home/presentation/manager/get_courses_cubit/get_courses_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/RecentCoursesSectionLoadingWidget.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/leatestCoursesGlideView.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class MoreInterestedCoursesViewBody extends StatefulWidget {
  const MoreInterestedCoursesViewBody({super.key});

  @override
  State<MoreInterestedCoursesViewBody> createState() =>
      _MoreInterestedCoursesViewBodyState();
}

class _MoreInterestedCoursesViewBodyState
    extends State<MoreInterestedCoursesViewBody> {
  late ScrollController scrollController;
  bool hasMore = true;
  List<CourseEntity> fetchedCourses = [];
  @override
  void initState() {
    super.initState();
    UserEntity user = getUserData();
    scrollController = ScrollController();
    context
        .read<GetCoursesCubit>()
        .getUserInterestedCourses(isPaginate: false, user: user);
    scrollController.addListener(() {
      if (_canFetchMore(state: context.read<GetCoursesCubit>().state)) {
        context
            .read<GetCoursesCubit>()
            .getUserInterestedCourses(isPaginate: true, user: user);
      }
    });
  }

  bool _canFetchMore({required GetCoursesState state}) =>
      hasMore &&
      scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 &&
      state is! GetUserInerestCoursesLoading;

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KHorizontalPadding,
        vertical: KVerticalPadding,
      ),
      child: BlocConsumer<GetCoursesCubit, GetCoursesState>(
          listener: (context, state) {
        if (state is GetUserInerestCoursesSuccess) {
          if (state.resonseEntity.isPaginate) {
            fetchedCourses.addAll(state.resonseEntity.courses);
          } else {
            fetchedCourses = state.resonseEntity.courses;
          }
          hasMore = state.resonseEntity.hasMore;
          setState(() {});
        }
      }, builder: (context, state) {
        if (state is GetUserInerestCoursesFailure) {
          return CustomErrorWidget(errormessage: state.errmessage);
        } else if (state is GetUserInerestCoursesLoading &&
            state.isPaginate == false) {
          return const RecentCoursesSectionLoadingWidget();
        } else if (state is GetUserInerestCoursesSuccess &&
            fetchedCourses.isEmpty) {
          return CustomEmptyWidget(
            text: LocaleKeys.noNewCourses,
          );
        } else {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              LeatestCourseSliverGrid(
                courses: fetchedCourses,
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: hasMore ? 20 : 0,
                ),
              ),
              SliverToBoxAdapter(
                child: state is GetUserInerestCoursesLoading && state.isPaginate
                    ? const RecentCoursesSectionLoadingWidget()
                    : const SizedBox(),
              ),
            ],
          );
        }
      }),
    );
  }
}
