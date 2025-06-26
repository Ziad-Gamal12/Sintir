import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/user_cubit/user_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CoursedetailviewBody.dart';

class Coursedetailview extends StatelessWidget {
  const Coursedetailview({super.key, required this.courseEntity});
  static String routeName = "/Coursedetailview";
  final CourseEntity courseEntity;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CourseSectionsCubit(
                getIt<CourseSectionsRepo>(), getIt<Assetspickerrepo>()),
          ),
          BlocProvider(
              create: (context) => CourseReportsCubit(
                  coursereportsrepo: getIt<CourseReportsRepo>())),
          BlocProvider(
              create: (context) => CourseFeedBacksCubit(
                  courseFeedBacksRepo: getIt<CourseFeedBacksRepo>())),
          BlocProvider(
              create: (context) => CourseSubscribtionsCubit(
                  course: courseEntity,
                  student: context.read<UserCubit>().studententity,
                  teacher: context.read<UserCubit>().teacherentity,
                  subscribtionRepo: getIt<CourseSubscibtionsRepo>()))
        ],
        child: Scaffold(
            appBar: const CustomAppBar(appBartitle: "تفاصيل الدورة"),
            body: CoursedetailviewBody(
              courseEntity: courseEntity,
            )));
  }
}
