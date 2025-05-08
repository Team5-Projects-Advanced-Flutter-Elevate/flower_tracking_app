import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/api_executor/api_executor.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/apply/data/api/api_client/apply_api_client.dart';
import 'package:flower_tracking_app/modules/apply/data/models/apply_response.dart';
import 'package:flower_tracking_app/modules/apply/data/models/vehicle_response.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/assets_paths/assets_paths.dart';
import '../datasource_contract/apply_datasource.dart';

@Injectable(as: ApplyDataSource)
class ApplyDataSourceImpl implements ApplyDataSource {
  ApplyApiClient applyApiClient;

  ApplyDataSourceImpl(this.applyApiClient);

  @override
  Future<ApiResult<ApplyResponseEntity>> applyDriver(
    DriverRequestModel model,
  ) async {
    var result = await ApiExecutor.executeApi(
      () => applyApiClient.applyDriver(model),
    );

    switch (result) {
      case Success<ApplyResponse>():
        return Success(data: result.data.toEntity());
      case Error<ApplyResponse>():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<VehicleResponseEntity>> getVehicles() async {
    var result = await ApiExecutor.executeApi(
      () => applyApiClient.getVehicles(),
    );

    switch (result) {
      case Success<VehicleResponse>():
        return Success(data: result.data.toEntity());
      case Error<VehicleResponse>():
        return Error(error: result.error);
    }
  }
}



@LazySingleton(as: CountryLoaderService)
class AssetCountryLoaderService implements CountryLoaderService {
  @override
  Future<String> loadCountryJson() {
    return rootBundle.loadString(AssetsPaths.countryJson);
  }
}


@LazySingleton(as: ImagePickerService)
class DefaultImagePickerService implements ImagePickerService {


  @override
  Future<File?> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}