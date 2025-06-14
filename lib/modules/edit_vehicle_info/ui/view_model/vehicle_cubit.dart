import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/apply/data/datasource_contract/apply_datasource.dart';
import 'package:flower_tracking_app/modules/edit_vehicle_info/data/models/edite_profile_response.dart';
import 'package:flower_tracking_app/modules/edit_vehicle_info/domain/usecases/edit_vehicle_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../apply/data/models/country_model.dart';
import '../../domain/entities/vehicle_response_entity.dart';
import '../../domain/usecases/get_vehicle_by_id_use_case.dart';
import '../../domain/usecases/get_vehicles_use_case.dart';

part 'vehicle_state.dart';

@injectable
class VehicleCubit extends Cubit<VehicleState> {
  VehicleCubit(
    this.editVehicleUseCase,
    this.getVehiclesUseCase,
    this.imagePickerService,
    this.getVehicleByIdUseCase,
  ) : super(const VehicleState()) {
    // _loadApplyData();
  }

  EditeVehicleUseCase editVehicleUseCase;
  GetVehiclesUseCase getVehiclesUseCase;
  ImagePickerService imagePickerService;
  GetVehicleByIdUseCase getVehicleByIdUseCase;

  Future<void> doIntent(VehicleIntent intent) async {
    switch (intent) {
      case EditVehicleIntent():
        _editeVehicle(intent.editeVehicleRequest);
      case SelectVehicleIntent():
        _selectVehicle(intent.vehicleEntity);
      case PickLicenseImageIntent():
        _pickLicenseImage(intent.source);
      case UnPickImageIntent():
        _unPickImage(intent.isLicenseImagePicked);
      case LoadVehiclesIntent():
        _loadVehicles();
      case PickImageIntent():
        _pickImage(intent.source);
      case GetVehicleByIdIntent():
        _getVehicleById(intent.id);
      case EnableIntent():
        _en();
    }
  }

  _en() {
    if (state.pickedLicenseImage != null) {
      emit(state.copyWith(buttonStatus: ButtonStatus.enable));
    }
  }

  Future<void> _getVehicleById(String id) async {
    emit(state.copyWith(loadVehicleStatus: LoadVehicleStatus.loading));
    var result = await getVehicleByIdUseCase.execute(id);
    switch (result) {
      case Success<VehicleResponseEntity>():
        _selectVehicle(result.data.vehicle);

      case Error<VehicleResponseEntity>():
        emit(
          state.copyWith(
            loadVehicleDataStatus: LoadVehicleDataStatus.error,
            loadVehicleError: result.error,
          ),
        );
    }
  }

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

  Future<void> _editeVehicle(EditVehicleRequest editeVehicleRequest) async {
    emit(
      state.copyWith(
        editeVehicleStatus: EditeVehicleStatus.loading,
        pickImageStatus: PickImageStatus.initial,
      ),
    );
    var result = await editVehicleUseCase.execute(editeVehicleRequest);
    switch (result) {
      case Success<EditProfileResponse>():
        emit(state.copyWith(editeVehicleStatus: EditeVehicleStatus.success));

      case Error<EditProfileResponse>():
        log(result.error.toString());
        emit(
          state.copyWith(
            editeVehicleStatus: EditeVehicleStatus.error,
            editVehicleError: result.error,
          ),
        );
    }
  }

  void _selectVehicle(VehicleEntity? vehicle) {
    emit(
      state.copyWith(
        selectedVehicle: vehicle,
        editeVehicleStatus: EditeVehicleStatus.initial,
        pickImageStatus: PickImageStatus.initial,
      ),
    );
  }

  void _pickLicenseImage(ImageSource source) async {
    var pickedImage = await _pickImage(source);
    emit(
      state.copyWith(
        pickedLicenseImage: pickedImage,
        isLicenseImagePicked: pickedImage != null ? true : false,
        editeVehicleStatus: EditeVehicleStatus.initial,
      ),
    );
  }

  void _unPickImage(bool isLicenseImagePicked) {
    if (isLicenseImagePicked) {
      emit(
        state.copyWith(
          pickedLicenseImage: null,
          isLicenseImagePicked: false,
          pickImageStatus: PickImageStatus.unPicked,
          editeVehicleStatus: EditeVehicleStatus.initial,
        ),
      );
    } else {
      emit(
        state.copyWith(
          pickImageStatus: PickImageStatus.unPicked,
          editeVehicleStatus: EditeVehicleStatus.initial,
        ),
      );
    }
  }

  Future<File?> _pickImage(ImageSource source) async {
    try {
      emit(state.copyWith(pickImageStatus: PickImageStatus.loading));
      final pickedFile = await imagePickerService.pickImage(source);
      if (pickedFile != null) {
        emit(
          state.copyWith(
            pickImageStatus: PickImageStatus.success,
            editeVehicleStatus: EditeVehicleStatus.initial,
          ),
        );
      }
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (error) {
      emit(
        state.copyWith(
          pickImageStatus: PickImageStatus.error,
          pickImageError: error,
          editeVehicleStatus: EditeVehicleStatus.initial,
        ),
      );
    }
    return null;
  }
}

sealed class VehicleIntent {}

class LoadVehiclesIntent extends VehicleIntent {}

class EditVehicleIntent extends VehicleIntent {
  final EditVehicleRequest editeVehicleRequest;

  EditVehicleIntent(this.editeVehicleRequest);
}

class SelectVehicleIntent extends VehicleIntent {
  final VehicleEntity? vehicleEntity;

  SelectVehicleIntent(this.vehicleEntity);
}

class PickLicenseImageIntent extends VehicleIntent {
  ImageSource source;

  PickLicenseImageIntent(this.source);
}

class PickImageIntent extends VehicleIntent {
  ImageSource source;

  PickImageIntent(this.source);
}

class UnPickImageIntent extends VehicleIntent {
  final bool isLicenseImagePicked;

  UnPickImageIntent(this.isLicenseImagePicked);
}

class GetVehicleByIdIntent extends VehicleIntent {
  final String id;

  GetVehicleByIdIntent(this.id);
}

class EnableIntent extends VehicleIntent {}
