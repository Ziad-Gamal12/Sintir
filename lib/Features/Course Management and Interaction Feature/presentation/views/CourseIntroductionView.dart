// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionViewBody.dart';

class CourseIntroductionView extends StatelessWidget {
  const CourseIntroductionView(
      {super.key, required this.bottomsheetnavigationrequirmentsentity});
  static const routeName = "/CourseIntroductionView";
  final DisplayCourseBottomsheetNavigationRequirmentsEntity
      bottomsheetnavigationrequirmentsentity;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CourseSectionsCubit(
            getIt<CourseSectionsRepo>(),
          ),
        ),
        BlocProvider(
            create: (context) => CourseSubscribtionsCubit(
                paymobRepo: getIt<PaymobRepo>(),
                course: bottomsheetnavigationrequirmentsentity.course,
                subscribtionRepo: getIt<CourseSubscibtionsRepo>()))
      ],
      child: Scaffold(
        appBar: CustomAppBar(
            appBartitle: bottomsheetnavigationrequirmentsentity.course.title),
        body: Provider.value(
          value: bottomsheetnavigationrequirmentsentity,
          child: const CourseIntroductionViewBody(),
        ),
      ),
    );
  }
}
