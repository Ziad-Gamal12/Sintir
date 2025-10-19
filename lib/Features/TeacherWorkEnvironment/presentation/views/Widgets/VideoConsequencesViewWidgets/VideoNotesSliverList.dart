import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/VideoNoteEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/CustomVideoNote.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/video_consequences_cubit/video_consequences_cubit.dart';
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
    return BlocBuilder<VideoConsequencesCubit, VideoConsequencesState>(
      buildWhen: (previous, current) {
        log("STATE TYPE => ${current.runtimeType}");
        if (current is VideoConsequencesGetVideoNotesSuccess ||
            current is VideoConsequencesGetVideoNotesLoading ||
            current is VideoConsequencesGetVideoNotesFailure) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is VideoConsequencesGetVideoNotesFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: CustomErrorWidget(errormessage: state.errmessage),
            ),
          );
        } else if (state is VideoConsequencesGetVideoNotesLoading &&
            state.isPaginate == false) {
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
        } else if (widget.notes.isEmpty &&
            state is VideoConsequencesGetVideoNotesSuccess) {
          return SliverToBoxAdapter(
            child: Center(
              child: CustomEmptyWidget(text: "لا يوجد ملاحظات"),
            ),
          );
        } else {
          return SliverList.builder(
              itemCount: widget.notes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
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
