import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponsListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponsListViewLoading.dart';
import 'package:sintir/constant.dart';

class CourseDetailsCouponsViewBody extends StatefulWidget {
  const CourseDetailsCouponsViewBody({super.key, required this.courseId});
  final String courseId;
  @override
  State<CourseDetailsCouponsViewBody> createState() =>
      _CourseDetailsCouponsViewBodyState();
}

class _CourseDetailsCouponsViewBodyState
    extends State<CourseDetailsCouponsViewBody> {
  List<CourseCouponEntity> coupons = [];
  bool hasMore = false;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    final cubit = context.read<CourseCouponsCubit>();

    cubit.getCourseCoupons(courseID: widget.courseId, isPaginate: false);

    scrollController.addListener(() {
      if (_shouldFetchMoreReports(cubit)) {
        cubit.getCourseCoupons(courseID: widget.courseId, isPaginate: true);
      }
    });
  }

  bool _shouldFetchMoreReports(CourseCouponsCubit cubit) {
    return scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! GetCourseCouponsLoading;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCouponsCubit, CourseCouponsState>(
      listener: (context, state) {
        if (state is GetCourseCouponsSuccess) {
          if (state.response.isPaginate) {
            setState(() {
              coupons.addAll(state.response.coupons);
            });
          } else {
            setState(() {
              coupons = state.response.coupons;
            });
          }
          hasMore = state.response.hasMore;
        }
      },
      builder: (context, state) {
        if (state is GetCourseCouponsFailure) {
          return Center(
            child: CustomErrorWidget(errormessage: state.errmessage),
          );
        } else if (state is GetCourseCouponsLoading && coupons.isEmpty) {
          return const CourseCouponsListViewLoading();
        } else if (coupons.isNotEmpty) {
          return CourseCouponsListView(
              scrollController: scrollController, coupons: coupons);
        } else if (state is! GetCourseCouponsLoading) {
          return CustomEmptyWidget(
            text: 'لا يوجد كوبونات حتى الان',
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: KMainColor,
          ));
        }
      },
    );
  }
}
