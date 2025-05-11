import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/core/models/driver/driver_dto.dart';
import 'package:flower_tracking_app/modules/apply/data/datasource_contract/apply_datasource.dart';
import 'package:flower_tracking_app/modules/apply/data/models/apply_response.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/data_sources_abstracts/driver/driver_collection.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo_contract/apply_repo_contract.dart';

@Injectable(as: ApplyRepo)
class ApplyRepoImpl implements ApplyRepo {
  ApplyDataSource applyDataSource;
  final DriverCollection driverCollection;

  ApplyRepoImpl({
    required this.applyDataSource,
    required this.driverCollection,
  });

  @override
  Future<ApiResult<ApplyResponseEntity>> applyDriver(
    DriverRequestModel model,
  ) async {
    var dataSourceResult = await applyDataSource.applyDriver(model);
    switch (dataSourceResult) {
      case Success<ApplyResponseEntity>():
        if (dataSourceResult.data.driver != null &&
            dataSourceResult.data.driver?.id != null) {
          var firestoreResult = await driverCollection.addDriver(
            DriverDto.convertIntoDto(dataSourceResult.data.driver),
          );
          switch (firestoreResult) {
            case Success<void>():
              return Success(data: dataSourceResult.data);
            case Error<void>():
              return Error(error: firestoreResult.error);
          }
        }
        return Success(data: dataSourceResult.data);
      case Error<ApplyResponseEntity>():
        return Error(error: dataSourceResult.error);
    }
  }

  @override
  Future<ApiResult<VehicleResponseEntity>> getVehicles() {
    return applyDataSource.getVehicles();
  }
}
