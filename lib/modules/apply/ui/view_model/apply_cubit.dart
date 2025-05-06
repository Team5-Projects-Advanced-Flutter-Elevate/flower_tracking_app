import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/usecases/apply_use_case.dart';
import 'package:flower_tracking_app/modules/apply/domain/usecases/get_vehicles_use_case.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/apply_response.dart';
import '../../data/models/country_model.dart';

part 'apply_state.dart';

@lazySingleton
class ApplyCubit extends Cubit<ApplyState> {
  ApplyCubit(this.applyDriverUseCase, this.getVehiclesUseCase)
    : super(const ApplyState()) {
    _loadApplyData();
  }

  ApplyDriverUseCase applyDriverUseCase;
  GetVehiclesUseCase getVehiclesUseCase;

  void doIntent(ApplyIntent intent) {
    switch (intent) {
      case LoadCountriesIntent():
        _loadCountries();
      case ApplyDriverIntent():
        _applyDriver(intent.driverRequestModel);
      case SelectCountryIntent():
        _selectCountry(intent.countryName);
      case SelectVehicleIntent():
        _selectVehicle(intent.vehicleName);
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

      final String jsonString = await rootBundle.loadString(
        AssetsPaths.countryJson,
      );
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
    emit(state.copyWith(applyDriverStatus: ApplyDriverStatus.loading));
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
    emit(state.copyWith(selectedCountry: countryName));
  }

  void _selectVehicle(String? vehicleName) {
    emit(state.copyWith(selectedVehicle: vehicleName));
  }

  void _selectGender(String? gender) {
    emit(state.copyWith(selectedGender: gender));
  }

  void _pickLicenseImage() async {
    var pickedImage = await pickImage();
    emit(
      state.copyWith(
        pickedLicenseImage: pickedImage,
        isLicenseImagePicked: pickedImage != null ? true : false,
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
        ),
      );
    } else {
      emit(
        state.copyWith(
          pickedIdImage: null,
          isIdImagePicked: false,
          pickImageStatus: PickImageStatus.unPicked,
        ),
      );
    }
  }

  void _pickIdImage() async {
    var pickedImage = await pickImage();
    emit(
      state.copyWith(
        pickedIdImage: pickedImage,
        isIdImagePicked: pickedImage != null ? true : false,
      ),
    );
  }

  Future<File?> pickImage() async {
    try {
      emit(state.copyWith(pickImageStatus: PickImageStatus.loading));
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
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

sealed class ApplyIntent {}

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
  final String? vehicleName;

  SelectVehicleIntent(this.vehicleName);
}

class SelectGenderIntent extends ApplyIntent {
  final String? gender;

  SelectGenderIntent(this.gender);
}

class PickLicenseImageIntent extends ApplyIntent {}

class PickIdImageIntent extends ApplyIntent {}

class UnPickImageIntent extends ApplyIntent {
  final bool isLicenseImagePicked;

  UnPickImageIntent(this.isLicenseImagePicked);
}
