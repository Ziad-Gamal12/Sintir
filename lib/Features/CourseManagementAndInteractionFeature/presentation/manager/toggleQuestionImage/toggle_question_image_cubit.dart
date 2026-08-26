import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'toggle_question_image_state.dart';

class ToggleQuestionImageCubit extends Cubit<ToggleQuestionImageState> {
  ToggleQuestionImageCubit() : super(ToggleQuestionImageInitial());
}
