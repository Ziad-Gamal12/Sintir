// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheetBody.dart';

class CourseBottomSheet extends StatefulWidget {
  const CourseBottomSheet({
    super.key,
    required this.courseEntity,
  });
  final CourseEntity courseEntity;

  @override
  State<CourseBottomSheet> createState() => _CourseBottomSheetState();
}

class _CourseBottomSheetState extends State<CourseBottomSheet> {
  @override
  Widget build(BuildContext context) {
    DisplayCourseBottomsheetNavigationRequirmentsEntity
        bottomsheetnavigationrequirmentsentity =
        DisplayCourseBottomsheetNavigationRequirmentsEntity(
            course: widget.courseEntity, isSubscribed: false);
    return BlocProvider(
      create: (context) => CourseSubscribtionsCubit(
        paymobRepo: getIt<PaymobRepo>(),
        subscribtionRepo: getIt<CourseSubscibtionsRepo>(),
        course: widget.courseEntity,
      ),
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border.all(color: Colors.grey.shade300, width: 1)),
          child: SafeArea(
            child: Provider.value(
              value: bottomsheetnavigationrequirmentsentity,
              child: const CourseBottomSheetBody(),
            ),
          ),
        ),
      ),
    );
  }
}
