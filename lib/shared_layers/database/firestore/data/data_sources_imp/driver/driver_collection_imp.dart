import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_tracking_app/core/apis/api_executor/api_executor.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:injectable/injectable.dart';
import '../../../constants/firestore_constants.dart';
import '../../../domain/entities/driver/driver_entity_firestore.dart';
import '../../data_sources_abstracts/driver/driver_collection.dart';
import '../../models/driver/driver_dto_firestore.dart';

@Injectable(as: DriverCollection)
class DriverCollectionImp implements DriverCollection {
  CollectionReference<DriverDtoFirestore> _getDriversCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return db
        .collection(FirestoreConstants.driversCollection)
        .withConverter(
          fromFirestore: (snapshot, options) {
            return DriverDtoFirestore.fromJson(snapshot.data());
          },
          toFirestore: (driverDto, options) {
            return driverDto.toJson();
          },
        );
  }

  @override
  Future<ApiResult<void>> addDriver(DriverEntityFirestore driverEntity) {
    return ApiExecutor.executeApi(
      () => _getDriversCollection()
          .doc(driverEntity.id)
          .set(DriverDtoFirestore.convertIntoDto(driverEntity)),
    );
  }

  @override
  Future<ApiResult<DriverEntityFirestore>> readDriver(String driverId) async {
    var documentSnapshot = await ApiExecutor.executeApi(
      () => _getDriversCollection().doc(driverId).get(),
    );
    switch (documentSnapshot) {
      case Success<DocumentSnapshot<DriverDtoFirestore>>():
        return Success(
          data:
              documentSnapshot.data.data()?.convertIntoEntity() ??
              DriverEntityFirestore(),
        );
      case Error<DocumentSnapshot<DriverDtoFirestore>>():
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
  Future<ApiResult<void>> updateDriverInfo(DriverEntityFirestore driverEntity) {
    var dtoToUpdateWith = DriverDtoFirestore(
      phone: driverEntity.phone,
      photo: driverEntity.photo,
      firstName: driverEntity.firstName,
      lastName: driverEntity.lastName,
      email: driverEntity.email,
      country: driverEntity.country,
      vehicleLicense: driverEntity.vehicleLicense,
      vehicleNumber: driverEntity.vehicleNumber,
      vehicleType: driverEntity.vehicleType,
    );
    return ApiExecutor.executeApi(
      () async => _getDriversCollection()
          .doc(driverEntity.id)
          .update(dtoToUpdateWith.toJson()),
    );
  }
}
