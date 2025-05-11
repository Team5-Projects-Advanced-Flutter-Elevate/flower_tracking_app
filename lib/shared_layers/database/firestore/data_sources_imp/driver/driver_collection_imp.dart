import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_tracking_app/core/apis/api_executor/api_executor.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/core/entities/driver/driver_entity.dart';
import 'package:flower_tracking_app/core/models/driver/driver_dto.dart';
import 'package:injectable/injectable.dart';
import '../../constants/firestore_constants.dart';
import '../../data_sources_abstracts/driver/driver_collection.dart';

@Injectable(as: DriverCollection)
class DriverCollectionImp implements DriverCollection {
  CollectionReference<DriverDto> _getDriversCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return db
        .collection(FirestoreConstants.driversCollection)
        .withConverter(
          fromFirestore: (snapshot, options) {
            return DriverDto.fromJson(snapshot.data());
          },
          toFirestore: (driverDto, options) {
            return driverDto.toJson();
          },
        );
  }

  @override
  Future<ApiResult<void>> addDriver(DriverDto driverDto) {
    return ApiExecutor.executeApi(
      () => _getDriversCollection().doc(driverDto.id).set(driverDto),
    );
  }

  @override
  Future<ApiResult<DriverEntity>> readDriver(String driverId) async {
    var documentSnapshot = await ApiExecutor.executeApi(
      () => _getDriversCollection().doc(driverId).get(),
    );
    switch (documentSnapshot) {
      case Success<DocumentSnapshot<DriverDto>>():
        return Success(
          data:
              documentSnapshot.data.data()?.convertIntoEntity() ??
              DriverEntity(),
        );
      case Error<DocumentSnapshot<DriverDto>>():
        return Error(error: documentSnapshot.error);
    }
  }

  @override
  Future<ApiResult<void>> deleteDriver(String driverId) {
    return ApiExecutor.executeApi(
      () => _getDriversCollection().doc(driverId).delete(),
    );
  }

  @override
  Future<ApiResult<void>> updateDriverInfo(DriverDto driverDto) {
    var dtoToUpdateWith = DriverDto(
      phone: driverDto.phone,
      photo: driverDto.photo,
      firstName: driverDto.firstName,
      lastName: driverDto.lastName,
      email: driverDto.email,
      country: driverDto.country,
    );
    return ApiExecutor.executeApi(
      () async => _getDriversCollection()
          .doc(driverDto.id)
          .update(dtoToUpdateWith.toJson()),
    );
  }
}
