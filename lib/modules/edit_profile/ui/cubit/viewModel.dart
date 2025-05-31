import 'package:flower_tracking_app/modules/edit_profile/ui/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/get_data.dart';
import '../../domain/usecase/get_data_usecase.dart';

@injectable
class EditProfileViewModel extends Cubit<ProfileState> {
  final GetDriverDataUseCase getLoggedDriverDataUseCase;

  @factoryMethod
  EditProfileViewModel(this.getLoggedDriverDataUseCase)
    : super(const ProfileState());

  void onIntent(EditIntent intent) {
    switch (intent) {
      case EditProfileIntent():
        _getLogedData();
        break;
    }
  }

  _getLogedData() async {
    emit(state.copyWith(getProfileDataStatus: EditProfileStatus.loading));
    var result = await getLoggedDriverDataUseCase.call();
    switch (result) {
      case Success<GetDataEntity>():
        emit(
          state.copyWith(
            getProfileDataStatus: EditProfileStatus.success,
            firstName: result.data.driver?.firstName,
            lastName: result.data.driver?.lastName,
            email: result.data.driver?.email,
            phoneNumber: result.data.driver?.phone,
            password: result.data.driver?.id,
            profilePhotoLink: result.data.driver?.photo,
          ),
        );

      case Error<GetDataEntity?>():
        emit(
          state.copyWith(
            getProfileDataStatus: EditProfileStatus.error,
            error: result.toString(),
          ),
        );
    }
  }
}

sealed class EditIntent {}

class EditProfileIntent extends EditIntent {}
