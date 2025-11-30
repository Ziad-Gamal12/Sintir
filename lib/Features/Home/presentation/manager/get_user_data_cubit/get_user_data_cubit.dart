import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/services/FireBase/FirebaseAuth_Service.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/locale_keys.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit({
    required this.authRepo,
    required this.authService,
  }) : super(GetUserDataInitial());

  final AuthRepo authRepo;
  final firebaseAuthService authService;
  bool isUserDataFetched = false;

  Future<void> fetchUserData() async {
    emit(GetUserDataLoading());

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return emit(GetUserDataFailure(errmessage: AuthMessages.userNotFound));
      }

      final deviceId = await authRepo.getDeviceId();
      if (deviceId.isEmpty) {
        return emit(
            GetUserDataFailure(errmessage: AuthMessages.deviceNotFound));
      }

      final result =
          await authRepo.fetchUserAndStoreLocally(uid: currentUser.uid);

      result.fold(
        (failure) => emit(GetUserDataFailure(errmessage: failure.message)),
        (_) async {
          final user = getUserData();
          if (user.deviceId != deviceId) {
            await authService.signout();
            return emit(
                GetUserDataFailure(errmessage: AuthMessages.deviceMismatch));
          }

          isUserDataFetched = true;
          emit(GetUserDataSuccess());
        },
      );
    } catch (e) {
      emit(GetUserDataFailure(errmessage: LocaleKeys.dataNotFound));
    }
  }
}

class AuthMessages {
  static String userNotFound = LocaleKeys.userNotFound;
  static String deviceNotFound = LocaleKeys.deviceNotFound;
  static String deviceMismatch = LocaleKeys.deviceMismatch;
}
