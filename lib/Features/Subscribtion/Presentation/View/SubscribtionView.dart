import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBody.dart';

class SubscribtionView extends StatelessWidget {
  const SubscribtionView({super.key, required this.requirmentsEntity});
  static const routeName = '/SubscribtionView';
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseSubscribtionsCubit(
        course: requirmentsEntity.course,
        paymobRepo: getIt<PaymobRepo>(),
        subscribtionRepo: getIt<CourseSubscibtionsRepo>(),
      ),
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "الأشتراك"),
        body: SubscribtionViewBody(
          requirmentsEntity: requirmentsEntity,
        ),
      ),
    );
  }
}
