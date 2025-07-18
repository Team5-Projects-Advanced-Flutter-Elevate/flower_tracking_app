import 'dart:io';

import 'package:flower_tracking_app/modules/edit_profile/data/datasource/upload_image.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/repo/upload_image.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/upload_image_response_entity.dart';

@Injectable(as: UploadImageRepo)
class UploadImageRepoImpl implements UploadImageRepo {
  UploadImageOnlineDataSource uploadImageOnlineDataSource;
  UploadImageRepoImpl(this.uploadImageOnlineDataSource);

  @override
  Future<ApiResult<UploadImageResponseEntity?>> uploadProfileImage({
    required File imageFile,
  }) {
    return uploadImageOnlineDataSource.uploadProfileImage(imageFile: imageFile);
  }
}
