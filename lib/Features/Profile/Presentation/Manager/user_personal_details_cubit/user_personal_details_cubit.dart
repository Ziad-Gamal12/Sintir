import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/Profile/Domain/Repos/PersonalDetailsRepo.dart';

part 'user_personal_details_state.dart';

class UserPersonalDetailsCubit extends Cubit<UserPersonalDetailsState> {
  UserPersonalDetailsCubit({required this.personalDetailsRepo})
      : super(UserPersonalDetailsInitial());
  final PersonalDetailsRepo personalDetailsRepo;

  Future<void> updatedUserProfilePic({required String uid}) async {
    emit(UpdatedUserProfilePicLoading());
    final result = await personalDetailsRepo.updatedUserProfilePic(uid: uid);
    result.fold(
        (l) => emit(UpdatedUserProfilePicFailure(errMessage: l.message)),
        (r) => emit(UpdatedUserProfilePicSuccess()));
  }
}
