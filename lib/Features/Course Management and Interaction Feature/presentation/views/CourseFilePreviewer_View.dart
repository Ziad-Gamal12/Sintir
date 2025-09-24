import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/file_item_cubit/file_item_cubit.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/File-Item-Repo/FileItemRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
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
      create: (context) => FileItemCubit(
        fileItemRepo: getIt<FileItemRepo>(),
        assetspickerrepo: getIt<Assetspickerrepo>(),
        sectionItemsActionsRepo: getIt<SectionItemsActionsRepo>(),
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
