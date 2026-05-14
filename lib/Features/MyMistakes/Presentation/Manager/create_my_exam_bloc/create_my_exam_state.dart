// create_my_exam_state.dart
part of 'create_my_exam_bloc.dart';

@immutable
class CreateMyExamState {
  final Map<String, int> mistakesCounts;
  final Map<String, bool> loadingStates;
  final Map<String, String?> errorMessages;

  const CreateMyExamState({
    this.mistakesCounts = const {},
    this.loadingStates = const {},
    this.errorMessages = const {},
  });

  CreateMyExamState copyWith({
    Map<String, int>? mistakesCounts,
    Map<String, bool>? loadingStates,
    Map<String, String?>? errorMessages,
  }) {
    return CreateMyExamState(
      mistakesCounts: mistakesCounts ?? this.mistakesCounts,
      loadingStates: loadingStates ?? this.loadingStates,
      errorMessages: errorMessages ?? this.errorMessages,
    );
  }
}
