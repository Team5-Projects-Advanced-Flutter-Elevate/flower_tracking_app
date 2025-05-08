import 'package:flower_tracking_app/modules/apply/data/models/vehicle_response.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VehicleResponse', () {
    test(
      'toEntity with non-null values should return VehicleResponseEntity with all fields',
          () {
        // Arrange
        final vehicleResponse = VehicleResponse(
          message: 'Success',
          vehicles: [
            Vehicle(
              id: 'veh_123',
              type: 'Truck',
              image: 'truck.jpg',
              createdAt: '2023-01-01',
              updatedAt: '2023-01-02',
              v: 0,
            )
          ],
          metadata: const Metadata(
            currentPage: 1,
            totalPages: 3,
            limit: 10,
            totalItems: 25,
          ),
        );

        // Act
        final result = vehicleResponse.toEntity();
        final jsonResult = vehicleResponse.toJson();

        // Verify all fields in JSON are not null
        jsonResult.forEach((key, value) {
          expect(value, isNotNull, reason: 'Field $key should not be null');
        });

        // Assert
        expect(result, isA<VehicleResponseEntity>());
        expect(result.message, equals('Success'));
        expect(result.vehicles?.length, equals(1));
        expect(result.vehicles?.first.type, equals('Truck'));
      },
    );

    test(
      'toEntity with null values should return VehicleResponseEntity with null fields',
          () {
        // Arrange
        const  vehicleResponse =  VehicleResponse();

        // Act
        final result = vehicleResponse.toEntity();
        final jsonResult = vehicleResponse.toJson();

        // Verify all fields in JSON are null
        jsonResult.forEach((key, value) {
          expect(value, isNull, reason: 'Field $key should be null');
        });

        // Assert
        expect(result, isA<VehicleResponseEntity?>());
        expect(result.message, isNull);
        expect(result.vehicles, isNull);
      },
    );
  });

  group('Vehicle', () {
    test(
      'toEntity with non-null values should return VehicleEntity with all fields',
          () {
        // Arrange
        final vehicle = Vehicle(
          id: 'veh_123',
          type: 'Truck',
          image: 'truck.jpg',
          createdAt: '2023-01-01',
          updatedAt: '2023-01-02',
          v: 0,
        );

        // Act
        final result = vehicle.toEntity();
        final jsonResult = vehicle.toJson();

        // Verify all fields in JSON are not null
        jsonResult.forEach((key, value) {
          expect(value, isNotNull, reason: 'Field $key should not be null');
        });

        // Assert
        expect(result, isA<VehicleEntity>());
        expect(result.id, equals('veh_123'));
        expect(result.type, equals('Truck'));
      },
    );

    test(
      'toEntity with null values should return VehicleEntity with null fields',
          () {
        // Arrange
        final vehicle = Vehicle();

        // Act
        final result = vehicle.toEntity();
        final jsonResult = vehicle.toJson();

        // Verify all fields in JSON are null
        jsonResult.forEach((key, value) {
          expect(value, isNull, reason: 'Field $key should be null');
        });

        // Assert
        expect(result, isA<VehicleEntity?>());
        expect(result.id, isNull);
        expect(result.type, isNull);
      },
    );
  });
}