import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/usecases/apply_use_case.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/apply_response.dart';
import '../../data/models/country_model.dart';

part 'apply_state.dart';

@lazySingleton
class ApplyCubit extends Cubit<ApplyState> {
  ApplyCubit(this.applyDriverUseCase) : super(const ApplyState());

  ApplyDriverUseCase applyDriverUseCase;

  Future<void> loadCountries() async {
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
          error: error,
        ),
      );
    }
  }

  Future<void> applyDriver(DriverRequestModel driverRequestModel) async {
    emit(state.copyWith(applyDriverStatus: ApplyDriverStatus.loading));
    var result = await applyDriverUseCase.execute(
      await driverRequestModel.toFormData(),
    );
    switch (result) {
      case Success<ApplyResponseEntity>():
        emit(state.copyWith(applyDriverStatus: ApplyDriverStatus.success));
      case Error<ApplyResponseEntity>():
        emit(
          state.copyWith(
            applyDriverStatus: ApplyDriverStatus.error,
            error: result.error,
          ),
        );
    }
  }

  void selectCountry(String? countryName) {
    emit(state.copyWith(selectedCountry: countryName));
  }

  void selectVehicle(String? vehicleName) {
    emit(state.copyWith(selectedVehicle: vehicleName));
  }

  void selectGender(String? gender) {
    emit(state.copyWith(selectedGender: gender));
  }

  void pickLicenseImage() async {
    var pickedImage = await pickImage();
    emit(
      state.copyWith(
        pickedLicenseImage: pickedImage,
        isLicenseImagePicked: pickedImage != null ? true : false,
      ),
    );
  }

  void unPickImage(bool isLicenseImagePicked) {
    if (isLicenseImagePicked) {
      emit(
        state.copyWith(pickedLicenseImage: null, isLicenseImagePicked: false),
      );
    } else {
      emit(state.copyWith(pickedIdImage: null, isIdImagePicked: false));
    }
  }

  void pickIdImage() async {
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
      emit(state.copyWith(pickImageStatus: PickImageStatus.success));
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (error) {
      emit(state.copyWith(pickImageStatus: PickImageStatus.error));
    }
    return null;
  }
}
