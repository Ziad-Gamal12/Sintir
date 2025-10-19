import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/VideoNoteEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/VideoConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoNotesSliverList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoSummaryCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/video_consequences_cubit/video_consequences_cubit.dart';
import 'package:sintir/constant.dart';

class VideoConsequencesViewBody extends StatefulWidget {
  const VideoConsequencesViewBody({super.key, required this.requirements});
  final VideoConsequencesViewRequirements requirements;

  @override
  State<VideoConsequencesViewBody> createState() =>
      _VideoConsequencesViewBodyState();
}

class _VideoConsequencesViewBodyState extends State<VideoConsequencesViewBody> {
  late ScrollController scrollController;
  VoidCallback? _scrollListener;
  bool hasMore = true;
  List<VideoNoteEntity> fetchedNotes = [];
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    final cubit = context.read<VideoConsequencesCubit>();
    cubit.getVideoItemNotes(
        videoId: widget.requirements.video.id,
        isPaginate: false,
        sectionId: widget.requirements.sectionID,
        courseId: widget.requirements.courseID);
    _scrollListener = () {
      if (_shouldFetchMore(cubit: cubit)) {
        cubit.getVideoItemNotes(
            videoId: widget.requirements.video.id,
            isPaginate: true,
            sectionId: widget.requirements.sectionID,
            courseId: widget.requirements.courseID);
      }
    };
    scrollController.addListener(_scrollListener!);
  }

  bool _shouldFetchMore({required VideoConsequencesCubit cubit}) {
    return scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! VideoConsequencesGetVideoNotesLoading;
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener!);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoConsequencesCubit, VideoConsequencesState>(
      listenWhen: (previous, current) {
        return current is VideoConsequencesGetVideoNotesSuccess ||
            current is VideoConsequencesGetVideoNotesFailure;
      },
      listener: (context, state) {
        if (state is VideoConsequencesGetVideoNotesSuccess) {
          if (state.response.isPaginate) {
            setState(() {
              fetchedNotes.addAll(state.response.notes);
            });
          } else {
            setState(() {
              fetchedNotes = state.response.notes;
            });
          }
          hasMore = state.response.hasMore;
        }
      },
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: KHorizontalPadding, vertical: KVerticalPadding),
            child: CustomScrollView(
                controller: scrollController,
                key: const PageStorageKey("VideoConsequencesViewBody"),
                slivers: [
                  SliverToBoxAdapter(
                      child:
                          VideoSummaryCard(requirements: widget.requirements)),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text("ملاحظات الفيديو",
                        textAlign: TextAlign.center,
                        style: AppTextStyles(context).bold20),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  VideoNotesSliverList(
                    notes: fetchedNotes,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: state is VideoConsequencesGetVideoNotesLoading &&
                              state.isPaginate
                          ? const CircularProgressIndicator(
                              color: KMainColor,
                            )
                          : null,
                    ),
                  )
                ]));
      },
    );
  }
}
