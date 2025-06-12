import 'dart:io';

import 'package:flower_tracking_app/modules/edit_profile/domain/entity/change_password.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/entity/edit_info.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/usecase/change_password_usecase.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/usecase/edit_info_usecase.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/usecase/upload_image.dart';
import 'package:flower_tracking_app/modules/edit_profile/ui/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/get_data.dart';
import '../../domain/entity/upload_image_response_entity.dart';
import '../../domain/usecase/get_data_usecase.dart';

@injectable
class EditProfileViewModel extends Cubit<ProfileState> {
  final GetDriverDataUseCase getLoggedDriverDataUseCase;
  final EditInfoUseCase editInfoUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  @factoryMethod
  EditProfileViewModel(
    this.getLoggedDriverDataUseCase,
    this.editInfoUseCase,
    this.uploadImageUseCase,
    this.changePasswordUseCase,
  ) : super(const ProfileState());

  void onIntent(EditIntent intent) {
    switch (intent) {
      case EditProfileIntent():
        _getLogedData();
        break;

      case EditInfo():
        _editInfo(
          intent.firstName,
          intent.lastName,
          intent.email,
          intent.phone,
        );
        break;

      case LoadProfileImageIntent():
        _uploadProfileImage(intent.imageFile);
        break;

      case ChangePassword():
        _changePassword(intent.password, intent.newPassword);
        break;
    }
  }

  Future<void> _getLogedData() async {
    emit(state.copyWith(getProfileDataStatus: EditProfileStatus.loading));

    var result = await getLoggedDriverDataUseCase.call();

    switch (result) {
      case Success<GetDataEntity>():
        final data = result.data.driver;

        // Build a new state with fetched data
        final updatedState = state.copyWith(
          getProfileDataStatus: EditProfileStatus.success,
          firstName: data?.firstName ?? '',
          lastName: data?.lastName ?? '',
          email: data?.email ?? '',
          phoneNumber: data?.phone ?? '',
          password: 'Mmmmm@123', // Default for UI placeholder only
          profilePhotoLink: data?.photo,
          gender: data?.gender,
        );

        // Save a snapshot of initial data for dirty-checking
        emit(updatedState.copyWith(initialData: updatedState));
        break;

      case Error<GetDataEntity?>():
        emit(
          state.copyWith(
            getProfileDataStatus: EditProfileStatus.error,
            error: result.toString(),
          ),
        );
        break;
    }
  }

  void _uploadProfileImage(File imageFile) async {
    emit(state.copyWith(uploadImageStatus: EditProfileStatus.loading));
    var result = await uploadImageUseCase.execute(imageFile: imageFile);
    switch (result) {
      case Success<UploadImageResponseEntity?>():
        final updatedState = state.copyWith(
          uploadImageStatus: EditProfileStatus.success,
        );
        emit(updatedState.copyWith(initialData: updatedState));
        break;

      case Error<UploadImageResponseEntity?>():
        emit(
          state.copyWith(
            getProfileDataStatus: EditProfileStatus.error,
            error: result.toString(),
          ),
        );
        break;
    }
  }

  _changePassword(String? password, String? newPassword) async {
    emit(state.copyWith(changePasswordStatus: EditProfileStatus.loading));
    var result = await changePasswordUseCase.call(password, newPassword);
    switch (result) {
      case Success<ChangePasswordEntity?>():
        final updatedState = state.copyWith(
          changePasswordStatus: EditProfileStatus.success,
        );
        emit(updatedState.copyWith(initialData: updatedState));
        break;

      case Error<ChangePasswordEntity?>():
        emit(
          state.copyWith(
            changePasswordStatus: EditProfileStatus.error,
            error: result.toString(),
          ),
        );
        break;
    }
  }

  Future<void> _editInfo(
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  ) async {
    emit(state.copyWith(updateProfileStatus: EditProfileStatus.loading));

    var result = await editInfoUseCase.call(firstName, lastName, email, phone);

    switch (result) {
      case Success<EditMyInfoEntity>():
        final data = result.data.driver;

        final updatedState = state.copyWith(
          updateProfileStatus: EditProfileStatus.success,
          firstName: data?.firstName ?? '',
          lastName: data?.lastName ?? '',
          email: data?.email ?? '',
          phoneNumber: data?.phone ?? '',
          password: 'Mmmmm@123', // UI-only placeholder
          profilePhotoLink: data?.photo,
          gender: data?.gender,
        );

        // After successful update, reset initial snapshot
        emit(updatedState.copyWith(initialData: updatedState));
        break;

      case Error<EditMyInfoEntity?>():
        emit(
          state.copyWith(
            updateProfileStatus: EditProfileStatus.error,
            error: result.toString(),
          ),
        );
        break;
    }
  }
}

sealed class EditIntent {}

class EditProfileIntent extends EditIntent {}

class EditInfo extends EditIntent {
  final String firstName;
  final String? lastName;
  final String? email;
  final String? phone;

  EditInfo(this.firstName, this.lastName, this.email, this.phone);
}

class LoadProfileImageIntent extends EditIntent {
  final File imageFile;

  LoadProfileImageIntent(this.imageFile);
}

class ChangePassword extends EditIntent {
  final String? password;
  final String? newPassword;
  ChangePassword(this.password, this.newPassword);
}
