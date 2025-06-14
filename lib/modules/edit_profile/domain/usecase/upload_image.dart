import 'dart:io';

import 'package:flower_tracking_app/modules/edit_profile/domain/repo/upload_image.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../entity/upload_image_response_entity.dart';

@injectable
class UploadImageUseCase {
  UploadImageRepo uploadImageRepo;

  UploadImageUseCase(this.uploadImageRepo);

  Future<ApiResult<UploadImageResponseEntity?>> execute({
    required File imageFile,
  }) => uploadImageRepo.uploadProfileImage(imageFile: imageFile);
}
