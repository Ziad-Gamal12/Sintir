import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/services/HiveService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Data/models/UserModel.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/RequiresPhoneNumber/Domain/Repos/UpdatePhoneNumberRepo.dart';

part 'update_user_phone_number_state.dart';

class UpdateUserPhoneNumberCubit extends Cubit<UpdateUserPhoneNumberState> {
  UpdateUserPhoneNumberCubit({required this.repo})
    : super(UpdateUserPhoneNumberInitial());
  final UpdatePhoneNumberRepo repo;
  Future<void> updatePhoneNumber({
    required String uid,
    required String phoneNumber,
  }) async {
    emit(UpdateUserPhoneNumberLoading());
    final result = await repo.updatePhoneNumber(
      uid: uid,
      phoneNumber: phoneNumber,
    );
    result.fold(
      (error) {
        emit(UpdateUserPhoneNumberFailure(errMessage: error.message));
      },
      (success) {
        UserEntity updatedUser = getUserData().copyWith(
          phoneNumber: phoneNumber,
        );
        final json = UserModel.fromEntity(updatedUser).toMap();
        Hive_Services.jsonSetter(
          key: BackendEndpoints.storeUserLocaly,
          value: json,
        );
        emit(UpdateUserPhoneNumberSuccess());
      },
    );
  }
}
