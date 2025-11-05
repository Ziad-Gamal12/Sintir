import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit({required this.authRepo}) : super(GetUserDataInitial());
  final AuthRepo authRepo;
  bool isUserDataFetched = false;

  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    if (FirebaseAuth.instance.currentUser == null) {
      emit(GetUserDataFailure(errmessage: 'المستخدم غير موجود'));
    } else {
      final userData = await authRepo.fetchUserAndStoreLocally(
          uid: FirebaseAuth.instance.currentUser!.uid);
      userData.fold((l) => emit(GetUserDataFailure(errmessage: l.message)),
          (r) {
        isUserDataFetched = true;
        emit(GetUserDataSuccess());
      });
    }
  }
}
