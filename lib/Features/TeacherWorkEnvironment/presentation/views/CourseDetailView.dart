import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CoursedetailviewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_Cubit.dart';

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({super.key, required this.courseEntity});
  static String routeName = "/Coursedetailview";
  final CourseEntity courseEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UpdateCourseCubit(
            coursesrepo: getIt<Coursesrepo>(),
            assetspickerrepo: getIt<Assetspickerrepo>()),
        child: Scaffold(
            key: Variables.courseDeatilsViewScaffoldKey,
            appBar: const CustomAppBar(appBartitle: "تفاصيل الدورة"),
            body: Builder(builder: (context) {
              return CourseDetailViewBody(
                courseEntity: courseEntity,
              );
            })));
  }
}
