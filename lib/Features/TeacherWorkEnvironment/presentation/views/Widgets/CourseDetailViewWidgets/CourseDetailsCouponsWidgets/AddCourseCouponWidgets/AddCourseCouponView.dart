import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/repos/CourseCouponsRepo/CourseCouponsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/AddCourseCouponWidgets/AddCourseCouponViewBody.dart';

class AddCourseCouponView extends StatefulWidget {
  const AddCourseCouponView({super.key, required this.courseId});
  static const String routeName = "/AddCourseCouponBottomSheetView";
  final String courseId;
  @override
  State<AddCourseCouponView> createState() => _AddCourseCouponViewState();
}

class _AddCourseCouponViewState extends State<AddCourseCouponView> {
  final CourseCouponEntity coupon = CourseCouponEntity(
      code: "",
      discountPercentage: 0,
      expiryDate: DateTime.now(),
      isActive: true,
      usageLimit: 0,
      usedCount: 0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseCouponsCubit(
        courseCouponsRepo: getIt<CourseCouponsRepo>(),
      ),
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "اضافة كوبون"),
        body: Provider.value(
            value: coupon,
            child: AddCourseCouponViewBody(
              courseId: widget.courseId,
            )),
      ),
    );
  }
}
