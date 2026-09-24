import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/services/FireBase/FirebaseAuth_Service.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/locale_keys.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit({
    required this.authRepo,
    required this.authService,
    FirebaseAuth? firebaseAuth,
    UserEntity Function()? readLocalUser,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _readLocalUser = readLocalUser ?? getUserData,
        super(GetUserDataInitial());

  final AuthRepo authRepo;
  final firebaseAuthService authService;
  final FirebaseAuth _firebaseAuth;
  final UserEntity Function() _readLocalUser;

  bool isUserDataFetched = false;

  Future<void> fetchUserData() async {
    if (state is GetUserDataLoading) return;
    _safeEmit(GetUserDataLoading());
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        return _safeEmit(
            GetUserDataFailure(errmessage: AuthMessages.userNotFound));
      }
      final deviceId = await authRepo.getDeviceId();
      if (deviceId.isEmpty) {
        return _safeEmit(
            GetUserDataFailure(errmessage: AuthMessages.deviceNotFound));
      }

      final result =
          await authRepo.fetchUserAndStoreLocally(uid: currentUser.uid);

      final errorMessage =
          result.fold<String?>((failure) => failure.message, (_) => null);
      if (errorMessage != null) {
        return _safeEmit(GetUserDataFailure(errmessage: errorMessage));
      }

      final user = _readLocalUser();
      if (user.deviceId != deviceId) {
        isUserDataFetched = false;
        try {
          await authService.signout();
        } catch (_) {
          GetUserDataFailure(errmessage: AuthMessages.deviceMismatch);
        }
        return _safeEmit(
            GetUserDataFailure(errmessage: AuthMessages.deviceMismatch));
      }

      isUserDataFetched = true;
      _safeEmit(GetUserDataSuccess());
    } catch (_) {
      _safeEmit(GetUserDataFailure(errmessage: LocaleKeys.dataNotFound));
    }
  }

  /// The cubit may be closed while a request is in flight (e.g. signout
  /// navigates away and disposes the screen). Emitting then throws.
  void _safeEmit(GetUserDataState newState) {
    if (!isClosed) emit(newState);
  }
}

class AuthMessages {
  static final String userNotFound = LocaleKeys.userNotFound;
  static final String deviceNotFound = LocaleKeys.deviceNotFound;
  static final String deviceMismatch = LocaleKeys.deviceMismatch;
}
