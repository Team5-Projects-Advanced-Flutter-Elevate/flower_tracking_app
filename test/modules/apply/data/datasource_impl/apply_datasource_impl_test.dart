import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/apply/data/api/api_client/apply_api_client.dart';
import 'package:flower_tracking_app/modules/apply/data/datasource_impl/apply_datasouce_impl.dart';
import 'package:flower_tracking_app/modules/apply/data/models/apply_response.dart';
import 'package:flower_tracking_app/modules/apply/data/models/vehicle_response.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apply_datasource_impl_test.mocks.dart';

@GenerateMocks([ApplyApiClient])
void main() {
  late MockApplyApiClient mockApplyApiClient;
  late ApplyDataSourceImpl applyDataSourceImpl;

  setUpAll(() {
    mockApplyApiClient = MockApplyApiClient();
    applyDataSourceImpl = ApplyDataSourceImpl(mockApplyApiClient);
  });

  group('ApplyDataSourceImpl', () {
    group('applyDriver', () {
      late Directory tempDir;
      late File nidFile;
      late File licenseFile;
      setUpAll(() {
        tempDir = Directory.systemTemp;
        nidFile = File('${tempDir.path}/nid.jpg')..createSync();
        licenseFile = File('${tempDir.path}/license.jpg')..createSync();
      });
      test(
        'should return Success with ApplyResponseEntity when API call succeeds',
        () async {
          // Arrange
          final mockRequestModel = DriverRequestModel(
            country: 'Country',
            vehicleType: '1',
            firstName: 'John',
            lastName: 'Doe',
            vehicleNumber: '123',
            vehicleLicense: licenseFile,
            nid: '123456789',
            nIDImg: nidFile,
            email: 'john@example.com',
            password: 'password',
            rePassword: 'password',
            gender: 'male',
          );
          const mockResponse = ApplyResponse(message: 'Success');
          when(
            mockApplyApiClient.applyDriver(mockRequestModel),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final result = await applyDataSourceImpl.applyDriver(
            mockRequestModel,
          );

          // Assert
          expect(result, isA<Success<ApplyResponseEntity>>());
          expect((result as Success).data, isA<ApplyResponseEntity>());
          verify(mockApplyApiClient.applyDriver(mockRequestModel)).called(1);

          // Clean up
          try {
            nidFile.deleteSync();
          } catch (e) {
            debugPrint(e.toString());
          }
          licenseFile.deleteSync();
        },
      );

      test('should return Error when API call fails', () async {
        // Arrange
        final mockRequestModel = DriverRequestModel();
        final mockError = Exception('null able date');
        when(
          mockApplyApiClient.applyDriver(mockRequestModel),
        ).thenThrow(mockError);

        // Act
        final result = await applyDataSourceImpl.applyDriver(mockRequestModel);

        // Assert
        expect(result, isA<Error<ApplyResponseEntity>>());
        expect((result as Error).error, equals(mockError));
        verify(mockApplyApiClient.applyDriver(mockRequestModel)).called(1);
      });
    });

    group('getVehicles', () {
      test(
        'should return Success with VehicleResponseEntity when API call succeeds',
        () async {
          // Arrange
          final mockResponse = VehicleResponse(
            message: 'Success',
            vehicles: [Vehicle(id: '1', type: 'Car')],
          );
          when(
            mockApplyApiClient.getVehicles(),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final result = await applyDataSourceImpl.getVehicles();

          // Assert
          expect(result, isA<Success<VehicleResponseEntity>>());
          expect((result as Success).data, isA<VehicleResponseEntity>());
          verify(mockApplyApiClient.getVehicles()).called(1);
        },
      );

      test('should return Error when API call fails', () async {
        // Arrange
        final mockError = DioException(
          requestOptions: RequestOptions(path: ''),
        );
        when(mockApplyApiClient.getVehicles()).thenThrow(mockError);

        // Act
        final result = await applyDataSourceImpl.getVehicles();

        // Assert
        expect(result, isA<Error<VehicleResponseEntity>>());
        expect((result as Error).error, equals(mockError));
        verify(mockApplyApiClient.getVehicles()).called(1);
      });
    });
  });
}
