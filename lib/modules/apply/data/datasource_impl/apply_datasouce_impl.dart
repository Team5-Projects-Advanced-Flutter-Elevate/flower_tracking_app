import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flower_tracking_app/core/apis/api_executor/api_executor.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/apply/data/api/api_client/apply_api_client.dart';
import 'package:flower_tracking_app/modules/apply/data/models/apply_response.dart';
import 'package:flower_tracking_app/modules/apply/data/models/vehicle_response.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/colors/app_colors.dart';
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
  final int maxFileSize = 1024 * 1024; // 1MB in bytes
  final int maxDimension = 1200; // Maximum width/height in pixels
  @override
  Future<File?> pickImage(ImageSource source) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    try {
      // Request permissions

      if (source == ImageSource.camera) {
        final permissionStatus = await Permission.camera.request();
        if (!permissionStatus.isGranted) return null;
      } else {
        if (androidInfo.version.sdkInt <= 32) {
          final permissionStatus = await Permission.storage.request();
          if (!permissionStatus.isGranted) return null;
        } else {
          final PermissionStatus permissionStatus =
              await Permission.photos.request();
          if (!permissionStatus.isGranted) return null;
        }
      }

      final XFile? pickedFile = await ImagePicker().pickImage(
        //source: ImageSource.gallery,
        source: source,
        requestFullMetadata: false, // For privacy-safe access
      );
      debugPrint('pickedFile: ${pickedFile?.path}');
      if (pickedFile == null) return null;

      // Process the image to meet requirements
      return await _processImage(File(pickedFile.path));
    } catch (e) {
      debugPrint('Image picker error: $e');
      return null;
    }
  }

  Future<File> _processImage(File originalImage) async {
    File processedImage = originalImage;
    int quality = 85; // Start with high quality

    // Check and reduce until under size limit
    while (true) {
      final fileSize = await processedImage.length();
      if (fileSize <= maxFileSize) break;

      // Reduce quality and/or dimensions
      quality = (quality * 0.8).round(); // Reduce quality by 20%
      processedImage = await _compressAndResizeImage(
        processedImage,
        quality: quality > 30 ? quality : 30, // Never go below 30% quality
      );

      // Final check to prevent infinite loops
      if (quality <= 30 && (await processedImage.length()) > maxFileSize) {
        throw Exception('Unable to compress image below 4MB');
      }
    }

    return processedImage;
  }

  Future<File> _compressAndResizeImage(File file, {int quality = 70}) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath = '${tempDir.path}/processed_${file.path.split('/').last}';

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality,
      minWidth: 600, // Minimum width after resize
      //minHeight: 1000, // Minimum height after resize
    );

    return File(result!.path);
  }

  Future<File?> showImageSourceDialog(
    BuildContext context, {
    required Function(File) onImageSelected,
  }) async {
    late File? image;
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt, color: AppColors.mainColor),
                  title: const Text('Take Photo'),
                  onTap: () async {
                    Navigator.pop(context);
                    image = await pickImage(ImageSource.camera);
                    if (image != null) onImageSelected(image!);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    image = await pickImage(ImageSource.gallery);
                    if (image != null) onImageSelected(image!);
                  },
                ),
              ],
            ),
          ),
    );

    return image;
  }
}
