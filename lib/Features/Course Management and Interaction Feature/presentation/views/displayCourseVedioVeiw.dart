import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/DisplaycoursevedioveiwBody.dart';

class Displaycoursevedioveiw extends StatelessWidget {
  const Displaycoursevedioveiw({
    super.key,
    required this.coursevideoviewnavigationsrequirmentsentity,
  });
  static const routeName = '/Displaycoursevedioveiw';
  final Coursevideoviewnavigationsrequirmentsentity
      coursevideoviewnavigationsrequirmentsentity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoItemCubit(
        videoItemRepo: getIt<VideoItemRepo>(),
        assetspickerrepo: getIt<Assetspickerrepo>(),
        sectionItemsActionsRepo: getIt<SectionItemsActionsRepo>(),
      ),
      child: Scaffold(
        key: Variables.DisplaycoursevedioveiwScaffoldKey,
        appBar: CustomAppBar(
            appBartitle:
                coursevideoviewnavigationsrequirmentsentity.video.title),
        body: Provider.value(
          value: coursevideoviewnavigationsrequirmentsentity,
          child: const DisplaycoursevedioveiwBody(),
        ),
      ),
    );
  }
}
