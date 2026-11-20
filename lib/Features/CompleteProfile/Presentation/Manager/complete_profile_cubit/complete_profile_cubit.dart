import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Entities/CompleteProfilePurpose.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Repos/ProfileCompletionRepo.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit({required this.repo})
    : super(const CompleteProfileInitial());

  final ProfileCompletionRepo repo;

  UserEntity get currentUser => repo.currentUser();

  Future<void> save(ProfileCompletionInput input) async {
    emit(CompleteProfileSaving());
    final result = await repo.completeProfile(input);
    result.fold(
      (failure) => emit(CompleteProfileFailure(failure.message)),
      (user) => emit(CompleteProfileSaved(user)),
    );
  }
}
