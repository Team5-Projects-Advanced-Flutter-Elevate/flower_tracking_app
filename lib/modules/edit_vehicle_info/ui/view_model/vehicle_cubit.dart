import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../../../core/utilities/image_picker.dart';
import '../../domain/entities/vehicle_response_entity.dart';
import '../../domain/usecases/get_vehicles_use_case.dart';

part 'vehicle_state.dart';

class VehicleCubit extends Cubit<VehicleState> {
  VehicleCubit(this.getVehiclesUseCase, this.imagePickerService)
    : super(const VehicleState());
  GetVehiclesUseCase getVehiclesUseCase;
  ImagePickerService imagePickerService;

  Future<void> _loadVehicles() async {
    emit(state.copyWith(loadVehicleStatus: LoadVehicleStatus.loading));
    var result = await getVehiclesUseCase.execute();
    switch (result) {
      case Success<VehicleResponseEntity>():
        emit(
          state.copyWith(
            loadVehicleStatus: LoadVehicleStatus.success,
            vehicles: result.data.vehicles,
          ),
        );
      case Error<VehicleResponseEntity>():
        emit(
          state.copyWith(
            loadVehicleStatus: LoadVehicleStatus.error,
            loadVehicleError: result.error,
          ),
        );
    }
  }

  void _pickLicenseImage(ImageSource source) async {
    var pickedImage = await _pickImage(source);
    emit(
      state.copyWith(
        pickedLicenseImage: pickedImage,
        isLicenseImagePicked: pickedImage != null ? true : false,
      ),
    );
  }

  Future<File?> _pickImage(ImageSource source) async {
    try {
      emit(state.copyWith(pickImageStatus: PickImageStatus.loading));
      final pickedFile = await imagePickerService.pickImage(source);
      if (pickedFile != null) {
        emit(state.copyWith(pickImageStatus: PickImageStatus.success));
      }
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (error) {
      emit(
        state.copyWith(
          pickImageStatus: PickImageStatus.error,
          pickImageError: error,
        ),
      );
    }
    return null;
  }
}
