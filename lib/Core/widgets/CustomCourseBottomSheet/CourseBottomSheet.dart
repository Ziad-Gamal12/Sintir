import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/PaymentCubit/payment_cubit.dart';
import 'package:sintir/Core/Managers/Cubits/user_cubit/user_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/repos/PaymentRepo/paymentRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheetBody.dart';

class CourseBottomSheet extends StatelessWidget {
  const CourseBottomSheet({
    super.key,
    required this.bottomsheetnavigationrequirmentsentity,
  });
  final Bottomsheetnavigationrequirmentsentity
      bottomsheetnavigationrequirmentsentity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(
        paymentrepo: getIt<Paymentrepo>(),
        course: bottomsheetnavigationrequirmentsentity.course,
        student: context.read<UserCubit>().studententity,
        teacher: context.read<UserCubit>().teacherentity,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.all(color: Colors.black, width: 1)),
        child: SafeArea(
          child: Provider.value(
            value: bottomsheetnavigationrequirmentsentity,
            child: const CourseBottomSheetBody(),
          ),
        ),
      ),
    );
  }
}
