import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersViewBody.dart';

class CourseDetailsSubscribersView extends StatelessWidget {
  const CourseDetailsSubscribersView({super.key, required this.courseEntity});
  static const routeName = '/CourseDetailsSubscribersView';

  final CourseEntity courseEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseSubscribtionsCubit(
          paymobRepo: getIt<PaymobRepo>(),
          course: courseEntity,
          subscribtionRepo: getIt<CourseSubscibtionsRepo>()),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: "الطلاب"),
        body: CourseDetailsSubscribersViewBody(
          courseEntity: courseEntity,
        ),
      ),
    );
  }
}
