import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/repos/CourseCouponsRepo/CourseCouponsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseDetailsCouponsViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseDetailsCouponsViewFloatingButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/cubit/coupon_item_actions_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailsCouponsView extends StatelessWidget {
  const CourseDetailsCouponsView({super.key, required this.courseId});
  static const routeName = '/CourseDetailsCouponsView';
  final String courseId;
  @override
  Widget build(BuildContext context) {
    final couponsRepo = getIt<CourseCouponsRepo>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<CourseCouponsCubit>(
          create: (_) => CourseCouponsCubit(
            courseCouponsRepo: couponsRepo,
          ),
        ),
        BlocProvider<CouponItemActionsCubit>(
          create: (_) => CouponItemActionsCubit(
            couponsRepo: couponsRepo,
          ),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.coupons),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            CourseDetailsCouponsViewFloatingButton(courseId: courseId),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: CourseDetailsCouponsViewBody(
            courseId: courseId,
          ),
        ),
      ),
    );
  }
}
