import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/apply/data/models/apply_response.dart';
import 'package:flower_tracking_app/modules/apply/domain/repo_contract/apply_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../entities/apply_response_entity.dart';

@injectable
class ApplyDriverUseCase {
  final ApplyRepo applyRepo;

  ApplyDriverUseCase(this.applyRepo);

  Future<ApiResult<ApplyResponseEntity>> execute(DriverRequestModel model) =>
      applyRepo.applyDriver(model);
}
