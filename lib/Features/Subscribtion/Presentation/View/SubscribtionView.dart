import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo/CourseCheckoutRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBody.dart';
import 'package:sintir/locale_keys.dart';

class SubscribtionView extends StatelessWidget {
  const SubscribtionView({super.key, required this.requirmentsEntity});
  static const routeName = '/SubscribtionView';
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CourseCheckoutCubit(getIt<CourseCheckoutGateway>()),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.subscription),
        body: SubscribtionViewBody(
          requirmentsEntity: requirmentsEntity,
        ),
      ),
    );
  }
}
