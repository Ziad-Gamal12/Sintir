part of 'toggle_question_image_cubit.dart';

@immutable
sealed class ToggleQuestionImageState {}

final class ToggleQuestionImageInitial extends ToggleQuestionImageState {}

final class ToggleQuestionImageSuccess extends ToggleQuestionImageState {}
