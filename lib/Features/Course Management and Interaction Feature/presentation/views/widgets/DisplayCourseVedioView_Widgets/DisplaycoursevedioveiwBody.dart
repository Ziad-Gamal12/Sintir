import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Video%20Previewer%20Widgets/CustomDisplayingVedioWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
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
                .read<CourseVideoViewNavigationsRequirmentsEntity>()
                .courseEntity
                .id,
            sectionId: context
                .read<CourseVideoViewNavigationsRequirmentsEntity>()
                .sectionId,
            sectionItemId: context
                .read<CourseVideoViewNavigationsRequirmentsEntity>()
                .video
                .id,
            joinedByEntity: JoinedByEntity(
                uid: getUserData().uid,
                name: getUserData().fullName,
                imageUrl: getUserData().profilePicurl,
                joinedDate: DateTime.now()),
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CourseVideoItemEntity vedio =
        context.read<CourseVideoViewNavigationsRequirmentsEntity>().video;
    return BlocConsumer<VideoItemCubit, VideoItemState>(
      listener: (context, state) {
        if (state is JoinToVideoItemSuccess) {
          ShowSnackBar(
              context: context,
              child: Text("تم الانضمام بنجاح",
                  style: AppTextStyles(context)
                      .regular14
                      .copyWith(color: Colors.black)),
              backgroundColor: Colors.grey.shade200);
        } else if (state is JoinToVideoItemFailure) {
          ShowSnackBar(
              context: context,
              child: Text(state.errMessage,
                  style: AppTextStyles(context)
                      .regular14
                      .copyWith(color: Colors.white)),
              backgroundColor: Colors.red);
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
