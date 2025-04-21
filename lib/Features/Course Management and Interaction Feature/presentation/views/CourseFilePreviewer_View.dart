import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFIlePreViewer_Widgets/CoursefilepreviewerViewBody.dart';

class CoursefilepreviewerView extends StatelessWidget {
  const CoursefilepreviewerView(
      {super.key, required this.coursefileviewnavigationsrequirmentsentity});
  static const routename = "/CoursefilepreviewerView";
  final Coursefileviewnavigationsrequirmentsentity
      coursefileviewnavigationsrequirmentsentity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseSectionsCubit(
        getIt<CourseSectionsRepo>(),
        getIt<Assetspickerrepo>(),
      ),
      child: Provider.value(
        value: coursefileviewnavigationsrequirmentsentity,
        child: Scaffold(
          appBar: CustomAppBar(
              appBartitle:
                  coursefileviewnavigationsrequirmentsentity.file.title),
          body: Coursefilepreviewerviewbody(
            file: coursefileviewnavigationsrequirmentsentity.file,
          ),
        ),
      ),
    );
  }
}
