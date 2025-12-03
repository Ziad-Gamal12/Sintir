import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/VideoNoteEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/CustomVideoNote.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/get_video_notes_cubit/get_video_notes_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VideoNotesSliverList extends StatefulWidget {
  const VideoNotesSliverList({super.key, required this.notes});
  final List<VideoNoteEntity> notes;
  @override
  State<VideoNotesSliverList> createState() => _VideoNotesSliverListState();
}

class _VideoNotesSliverListState extends State<VideoNotesSliverList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetVideoNotesCubit, GetVideoNotesState>(
      builder: (context, state) {
        if (state is GetVideoNotesFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: CustomErrorWidget(errormessage: state.errmessage),
            ),
          );
        } else if (state is GetVideoNotesLoading && state.isPaginate == false) {
          return SliverToBoxAdapter(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: getFakeLoadingNotes().length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Skeletonizer(
                      enabled: true,
                      child: CustomVideoNote(
                        note: getFakeLoadingNotes()[index],
                      ),
                    ),
                  );
                }),
          );
        } else if (widget.notes.isEmpty && state is GetVideoNotesSuccess) {
          return SliverToBoxAdapter(
            child: Center(
              child: CustomEmptyWidget(text: LocaleKeys.noNotes),
            ),
          );
        } else {
          return SliverList.builder(
              itemCount: widget.notes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomVideoNote(
                    note: widget.notes[index],
                  ),
                );
              });
        }
      },
    );
  }

  List<VideoNoteEntity> getFakeLoadingNotes() =>
      List.generate(6, (index) => VideoNoteEntity.empty());
}
