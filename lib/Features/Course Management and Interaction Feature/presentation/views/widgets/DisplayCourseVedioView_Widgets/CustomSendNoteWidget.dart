import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart'
    show SectionItemsActionsRepo;
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/VideoNoteEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/CustomSendNoteWidgetBody.dart';

class CustomSendNoteWidget extends StatefulWidget {
  const CustomSendNoteWidget({
    super.key,
    required this.coursevideoviewnavigationsrequirmentsentity,
  });

  final Coursevideoviewnavigationsrequirmentsentity
      coursevideoviewnavigationsrequirmentsentity;
  @override
  State<CustomSendNoteWidget> createState() => _CustomSendNoteWidgetState();
}

class _CustomSendNoteWidgetState extends State<CustomSendNoteWidget> {
  late VideoNoteEntity note;

  @override
  void initState() {
    super.initState();
    note = VideoNoteEntity(
        user: getUserData(), dateTime: DateTime.now(), note: "");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoItemCubit(
        videoItemRepo: getIt<VideoItemRepo>(),
        assetspickerrepo: getIt<Assetspickerrepo>(),
        sectionItemsActionsRepo: getIt<SectionItemsActionsRepo>(),
      ),
      child: Provider.value(
        value: note,
        child: CustomSendNoteWidgetBody(
          coursevideoviewnavigationsrequirmentsentity:
              widget.coursevideoviewnavigationsrequirmentsentity,
        ),
      ),
    );
  }
}
