import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/AdaptiveSliverGrid.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/VideoNoteEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/CustomVideoNote.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/get_video_notes_cubit/get_video_notes_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VideoNotesSliverList extends StatelessWidget {
  const VideoNotesSliverList({super.key, required this.notes});
  final List<VideoNoteEntity> notes;

  static final List<VideoNoteEntity> _fakeNotes = List.generate(
    6,
    (_) => VideoNoteEntity.empty(),
  );

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
        }
        if (state is GetVideoNotesLoading && state.isPaginate == false) {
          return AdaptiveSliverGrid(
            itemCount: _fakeNotes.length,
            itemBuilder: (_, i) => Skeletonizer(
              enabled: true,
              child: CustomVideoNote(note: _fakeNotes[i]),
            ),
          );
        }
        if (notes.isEmpty && state is GetVideoNotesSuccess) {
          return SliverToBoxAdapter(
            child: Center(child: CustomEmptyWidget(text: LocaleKeys.noNotes)),
          );
        }
        return AdaptiveSliverGrid(
          itemCount: notes.length,

          itemBuilder: (_, i) => CustomVideoNote(note: notes[i]),
        );
      },
    );
  }
}
