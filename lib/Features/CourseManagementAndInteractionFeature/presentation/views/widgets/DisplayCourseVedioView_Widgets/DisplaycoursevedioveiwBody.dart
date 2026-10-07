import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/VideoPreviewerWidgets/CustomDisplayingVedioWidget.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/DisplayCourseVedioView_Widgets/CustomSendNoteText.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/addingJoinedByLoadingWidget.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class DisplaycoursevedioveiwBody extends StatefulWidget {
  const DisplaycoursevedioveiwBody({
    super.key,
  });

  @override
  State<DisplaycoursevedioveiwBody> createState() =>
      _DisplaycoursevedioveiwBodyState();
}

class _DisplaycoursevedioveiwBodyState
    extends State<DisplaycoursevedioveiwBody> {
  String? _playbackUrl;
  bool _playbackLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final requirement =
          context.read<CourseVideoViewNavigationsRequirmentsEntity>();
      final video = requirement.video;
      if (video.videoProvider == "mux" && video.status == "ready") {
        _loadMuxPlayback(requirement);
      }
      context.read<VideoItemCubit>().joinToVideoItem(
            courseId: requirement.courseEntity.id,
            sectionId: requirement.sectionId,
            sectionItemId: video.id,
            joinedByEntity: JoinedByEntity(
                uid: getUserData().uid,
                name: getUserData().fullName,
                imageUrl: getUserData().profilePicurl,
                joinedDate: DateTime.now()),
          );
    });
  }

  Future<void> _loadMuxPlayback(
      CourseVideoViewNavigationsRequirmentsEntity requirement) async {
    setState(() => _playbackLoading = true);
    final result = await getIt<VideoItemRepo>().getPlaybackUrl(
      courseId: requirement.courseEntity.id,
      sectionId: requirement.sectionId,
      videoId: requirement.video.id,
    );
    if (!mounted) return;
    result.fold(
        (_) => setState(() => _playbackLoading = false),
        (url) => setState(() {
              _playbackUrl = url;
              _playbackLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final CourseVideoItemEntity vedio =
        context.read<CourseVideoViewNavigationsRequirmentsEntity>().video;
    return BlocConsumer<VideoItemCubit, VideoItemState>(
      listener: (context, state) {
        if (state is JoinToVideoItemSuccess) {
          CustomSnackBar.show(
            context,
            message: LocaleKeys.registrationSuccess,
            type: SnackType.success,
          );
        } else if (state is JoinToVideoItemFailure) {
          CustomSnackBar.show(
            context,
            message: state.errMessage,
            type: SnackType.error,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: KHorizontalPadding, vertical: KVerticalPadding),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          if (vedio.videoProvider == "mux")
                            if (vedio.status != "ready")
                              Text(vedio.status == "failed"
                                  ? LocaleKeys.videoPlayFailed
                                  : "Video is processing")
                            else if (_playbackLoading)
                              const CircularProgressIndicator()
                            else if (_playbackUrl != null)
                              PremiumVideoPlayer(
                                videoUrl: _playbackUrl,
                              )
                            else
                              Text(LocaleKeys.videoPlayFailed)
                          else
                            PremiumVideoPlayer(videoUrl: vedio.vedioUrl),
                          const SizedBox(
                            height: 32,
                          ),
                          const CustomSendNoteText(),
                        ],
                      ),
                    ),
                  ],
                )),
            Visibility(
                visible: state is JoinToVideoItemLoading ? true : false,
                child: const Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: addingJoinedByLoadingWidget()))
          ],
        );
      },
    );
  }
}
