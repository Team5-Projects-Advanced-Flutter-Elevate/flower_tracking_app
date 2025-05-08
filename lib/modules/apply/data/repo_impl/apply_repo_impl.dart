import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/apply/data/datasource_contract/apply_datasource.dart';

import 'package:flower_tracking_app/modules/apply/data/models/apply_response.dart';

import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo_contract/apply_repo_contract.dart';

@Injectable(as: ApplyRepo)
class ApplyRepoImpl implements ApplyRepo {
  ApplyDataSource applyDataSource;

  ApplyRepoImpl({required this.applyDataSource});

  @override
  Future<ApiResult<ApplyResponseEntity>> applyDriver(DriverRequestModel model) {
    return applyDataSource.applyDriver(model);
  }

  @override
  Future<ApiResult<VehicleResponseEntity>> getVehicles() {
    return applyDataSource.getVehicles();
  }
}
