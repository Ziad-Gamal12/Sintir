// create_my_exam_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';

part 'create_my_exam_event.dart';
part 'create_my_exam_state.dart';

class CreateMyExamBloc extends Bloc<CreateMyExamEvent, CreateMyExamState> {
  final MyMistakesRepo myMistakesRepo;

  CreateMyExamBloc({required this.myMistakesRepo})
      : super(const CreateMyExamState()) {
    on<GetAllSubjectsMistakesCountEvent>((event, emit) async {
      for (var id in event.subjectIds) {
        add(GetSubjectsMistakesCountEvent(
            subjectId: id, userUID: event.userUID));
      }
    });
    on<GetSubjectsMistakesCountEvent>(
      (event, emit) async {
        emit(state.copyWith(
          loadingStates: Map.of(state.loadingStates)..[event.subjectId] = true,
          errorMessages: Map.of(state.errorMessages)..[event.subjectId] = null,
        ));

        final result = await myMistakesRepo.getSubjectTotalMistakes(
            userUID: event.userUID, subjectId: event.subjectId);

        result.fold(
          (failure) {
            emit(state.copyWith(
              loadingStates: Map.of(state.loadingStates)
                ..[event.subjectId] = false,
              errorMessages: Map.of(state.errorMessages)
                ..[event.subjectId] = failure.message,
            ));
          },
          (count) {
            emit(state.copyWith(
              loadingStates: Map.of(state.loadingStates)
                ..[event.subjectId] = false,
              mistakesCounts: Map.of(state.mistakesCounts)
                ..[event.subjectId] = count,
            ));
          },
        );
      },
      transformer: concurrent(),
    );
  }
}
