import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
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
      context.read<CourseSectionsCubit>().addJoinedBy(
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
            joinedByEntity: context
                .read<CourseSectionsCubit>()
                .getJoinedByEntity(context: context),
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Coursevedioitementity vedio =
        context.read<Coursevideoviewnavigationsrequirmentsentity>().video;

    return BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
      listener: (context, state) {
        if (state is AddJoinedBySuccess) {
          showSnackBar(context, "تم الانضمام بنجاح");
        } else if (state is AddJoinedByFailure) {
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
                visible: state is AddJoinedByLoading ? true : false,
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
