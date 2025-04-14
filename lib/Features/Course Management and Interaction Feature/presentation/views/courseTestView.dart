import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/manager/update_course_sections_cubit/updatecoursesectionsCubit.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CoursetestviewBody.dart';

class Coursetestview extends StatelessWidget {
  const Coursetestview(
      {super.key, required this.coursetestviewnavigationsrequirmentsentity});
  static const routename = "/Coursetestview";
  final Coursetestviewnavigationsrequirmentsentity
      coursetestviewnavigationsrequirmentsentity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateCourseSectionsCubit(
        coursesrepo: getIt<Coursesrepo>(),
      ),
      child: Provider.value(
        value: coursetestviewnavigationsrequirmentsentity,
        child: Scaffold(
          appBar: CustomAppBar(
              appBartitle:
                  coursetestviewnavigationsrequirmentsentity.test.title),
          body: CoursetestviewBody(
            coursetestentity: coursetestviewnavigationsrequirmentsentity.test,
          ),
        ),
      ),
    );
  }
}
