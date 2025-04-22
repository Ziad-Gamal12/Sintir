import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/user_cubit/user_cubit.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/widgets/Video%20Previewer%20Widgets/CustomDisplayingVedioWidget.dart';
import 'package:sintir/Core/widgets/showSnackBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/CustomSendNoteText.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/addingJoinedByLoadingWidget.dart';
import 'package:sintir/constant.dart';

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
  @override
  void initState() {
    if (mounted) {
      context.read<VideoItemCubit>().joinToVideoItem(
            courseId: context
                .read<Coursevideoviewnavigationsrequirmentsentity>()
                .courseEntity
                .id,
            sectionId: context
                .read<Coursevideoviewnavigationsrequirmentsentity>()
                .sectionId,
            sectionItemId: context
                .read<Coursevideoviewnavigationsrequirmentsentity>()
                .video
                .id,
            joinedByEntity: context.read<UserCubit>().getJoinedByEntity(),
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Coursevedioitementity vedio =
        context.read<Coursevideoviewnavigationsrequirmentsentity>().video;
    return BlocConsumer<VideoItemCubit, VideoItemState>(
      listener: (context, state) {
        if (state is JoinToVideoItemSuccess) {
          showSnackBar(context, "تم الانضمام بنجاح");
        } else if (state is JoinToVideoItemFailure) {
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          CustomDisplayingVideoWidget(
                            videoUrl: vedio.vedioUrl,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomSendNoteText(),
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
