import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/apply/data/datasource_contract/apply_datasource.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/usecases/apply_use_case.dart';
import 'package:flower_tracking_app/modules/apply/domain/usecases/get_vehicles_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/apply_response.dart';
import '../../data/models/country_model.dart';

part 'apply_state.dart';

@lazySingleton
class ApplyCubit extends Cubit<ApplyState> {
  ApplyCubit(
    this.applyDriverUseCase,
    this.getVehiclesUseCase,
    this.countryLoaderService,
    this.imagePickerService,
  ) : super(const ApplyState()) {
    // _loadApplyData();
  }

  ApplyDriverUseCase applyDriverUseCase;
  GetVehiclesUseCase getVehiclesUseCase;
  CountryLoaderService countryLoaderService;
  ImagePickerService imagePickerService;

  Future<void> doIntent(ApplyIntent intent) async {
    switch (intent) {
      case LoadApplyDataIntent():
        _loadApplyData();
      case LoadCountriesIntent():
        _loadCountries();
      case ApplyDriverIntent():
        _applyDriver(intent.driverRequestModel);
      case SelectCountryIntent():
        _selectCountry(intent.countryName);
      case SelectVehicleIntent():
        _selectVehicle(intent.vehicleEntity);
      case SelectGenderIntent():
        _selectGender(intent.gender);
      case PickLicenseImageIntent():
        _pickLicenseImage();
      case PickIdImageIntent():
        _pickIdImage();
      case UnPickImageIntent():
        _unPickImage(intent.isLicenseImagePicked);
      case LoadVehiclesIntent():
        _loadVehicles();
      case PickImageIntent():
        _pickImage();
    }
  }

  Future<void> _loadApplyData() async {
    emit(state.copyWith(loadApplyDataStatus: LoadApplyDataStatus.loading));
    await _loadCountries();
    await _loadVehicles();
    if (state.loadCountryStatus == LoadCountryStatus.success &&
        state.loadVehicleStatus == LoadVehicleStatus.success) {
      emit(state.copyWith(loadApplyDataStatus: LoadApplyDataStatus.success));
    } else {
      emit(state.copyWith(loadApplyDataStatus: LoadApplyDataStatus.error));
    }
  }

  Future<void> _loadCountries() async {
    try {
      emit(state.copyWith(loadCountryStatus: LoadCountryStatus.loading));

      final String jsonString = await countryLoaderService.loadCountryJson();
      final List<dynamic> jsonList = json.decode(jsonString);
      List<CountryModel> countryList =
          jsonList.map((json) => CountryModel.fromJson(json)).toList();

      emit(
        state.copyWith(
          loadCountryStatus: LoadCountryStatus.success,
          countries: countryList,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          loadCountryStatus: LoadCountryStatus.error,
          loadCountryError: error,
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

  Future<void> _applyDriver(DriverRequestModel driverRequestModel) async {
    emit(
      state.copyWith(
        applyDriverStatus: ApplyDriverStatus.loading,
        pickImageStatus: PickImageStatus.initial,
      ),
    );
    var result = await applyDriverUseCase.execute(driverRequestModel);
    switch (result) {
      case Success<ApplyResponseEntity>():
        emit(state.copyWith(applyDriverStatus: ApplyDriverStatus.success));
      case Error<ApplyResponseEntity>():
        log(result.error.toString());
        emit(
          state.copyWith(
            applyDriverStatus: ApplyDriverStatus.error,
            applyDriverError: result.error,
          ),
        );
    }
  }

  void _selectCountry(String? countryName) {
    emit(
      state.copyWith(
        selectedCountry: countryName,
        applyDriverStatus: ApplyDriverStatus.initial,
        pickImageStatus: PickImageStatus.initial,
      ),
    );
  }

  void _selectVehicle(VehicleEntity? vehicle) {
    emit(
      state.copyWith(
        selectedVehicle: vehicle,
        applyDriverStatus: ApplyDriverStatus.initial,
        pickImageStatus: PickImageStatus.initial,
      ),
    );
  }

  void _selectGender(String? gender) {
    emit(
      state.copyWith(
        selectedGender: gender,
        applyDriverStatus: ApplyDriverStatus.initial,
        pickImageStatus: PickImageStatus.initial,
      ),
    );
  }

  void _pickLicenseImage() async {
    var pickedImage = await _pickImage();
    emit(
      state.copyWith(
        pickedLicenseImage: pickedImage,
        isLicenseImagePicked: pickedImage != null ? true : false,
        applyDriverStatus: ApplyDriverStatus.initial,
      ),
    );
  }

  void _pickIdImage() async {
    var pickedImage = await _pickImage();
    emit(
      state.copyWith(
        pickedIdImage: pickedImage,
        isIdImagePicked: pickedImage != null ? true : false,
        applyDriverStatus: ApplyDriverStatus.initial,
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
          applyDriverStatus: ApplyDriverStatus.initial,
        ),
      );
    } else {
      emit(
        state.copyWith(
          pickedIdImage: null,
          isIdImagePicked: false,
          pickImageStatus: PickImageStatus.unPicked,
          applyDriverStatus: ApplyDriverStatus.initial,
        ),
      );
    }
  }

  Future<File?> _pickImage() async {
    try {
      emit(state.copyWith(pickImageStatus: PickImageStatus.loading));
      final pickedFile = await imagePickerService.pickImageFromGallery();
      if (pickedFile != null) {
        emit(
          state.copyWith(
            pickImageStatus: PickImageStatus.success,
            applyDriverStatus: ApplyDriverStatus.initial,
          ),
        );
      }
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (error) {
      emit(
        state.copyWith(
          pickImageStatus: PickImageStatus.error,
          pickImageError: error,
          applyDriverStatus: ApplyDriverStatus.initial,
        ),
      );
    }
    return null;
  }
}

sealed class ApplyIntent {}

class LoadApplyDataIntent extends ApplyIntent {}

class LoadCountriesIntent extends ApplyIntent {}

class LoadVehiclesIntent extends ApplyIntent {}

class ApplyDriverIntent extends ApplyIntent {
  final DriverRequestModel driverRequestModel;

  ApplyDriverIntent(this.driverRequestModel);
}

class SelectCountryIntent extends ApplyIntent {
  final String? countryName;

  SelectCountryIntent(this.countryName);
}

class SelectVehicleIntent extends ApplyIntent {
  final VehicleEntity? vehicleEntity;

  SelectVehicleIntent(this.vehicleEntity);
}

class SelectGenderIntent extends ApplyIntent {
  final String? gender;

  SelectGenderIntent(this.gender);
}

class PickLicenseImageIntent extends ApplyIntent {}

class PickIdImageIntent extends ApplyIntent {}

class PickImageIntent extends ApplyIntent {}

class UnPickImageIntent extends ApplyIntent {
  final bool isLicenseImagePicked;

  UnPickImageIntent(this.isLicenseImagePicked);
}
