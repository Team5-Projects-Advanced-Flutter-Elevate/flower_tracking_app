import 'dart:io';

import 'package:flower_tracking_app/core/entities/driver/driver_entity.dart';
import 'package:flower_tracking_app/core/models/driver/driver_dto.dart';
import 'package:flower_tracking_app/modules/apply/data/models/apply_response.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApplyResponse', () {
    test(
      'toEntity with non-null values should return ApplyResponseEntity with all fields',
      () {
        // Arrange
        final applyResponse = ApplyResponse(
          message: 'Success',
          driver: DriverDto(
            country: 'Country',
            firstName: 'John',
            lastName: 'Doe',
            vehicleType: '1',
            vehicleNumber: '123',
            vehicleLicense: 'license.jpg',
            nid: '123456789',
            nIDImg: 'nid.jpg',
            email: 'john@example.com',
            gender: 'male',
            phone: '1234567890',
            photo: 'photo.jpg',
            role: 'driver',
            id: 'driver_123',
            createdAt: '2023-01-01',
          ),
          token: 'token123',
        );

        // Act
        final result = applyResponse.toEntity();
        final jsonResult = applyResponse.toJson();

        // Verify all fields in JSON are not null
        jsonResult.forEach((key, value) {
          expect(value, isNotNull, reason: 'Field $key should not be null');
        });

        // Assert
        expect(result, isA<ApplyResponseEntity>());
        expect(result.message, equals('Success'));
        expect(result.token, equals('token123'));
        expect(result.driver, isNotNull);
      },
    );

    test(
      'toEntity with null values should return ApplyResponseEntity with null fields',
      () {
        // Arrange
        const applyResponse = ApplyResponse();

        // Act
        final result = applyResponse.toEntity();
        final jsonResult = applyResponse.toJson();

        // Verify all fields in JSON are null
        jsonResult.forEach((key, value) {
          expect(value, isNull, reason: 'Field $key should be null');
        });

        // Assert
        expect(result, isA<ApplyResponseEntity?>());
        expect(result.message, isNull);
        expect(result.token, isNull);
        expect(result.driver, isNull);
      },
    );
  });

  group('Driver', () {
    test(
      'toEntity with non-null values should return DriverEntity with all fields',
      () {
        // Arrange
        final driver = DriverDto(
          country: 'Country',
          firstName: 'John',
          lastName: 'Doe',
          vehicleType: '1',
          vehicleNumber: '123',
          vehicleLicense: 'license.jpg',
          nid: '123456789',
          nIDImg: 'nid.jpg',
          email: 'john@example.com',
          gender: 'male',
          phone: '1234567890',
          photo: 'photo.jpg',
          role: 'driver',
          id: 'driver_123',
          createdAt: '2023-01-01',
        );

        // Act
        final result = driver.convertIntoEntity();
        final jsonResult = driver.toJson();

        // Verify all fields in JSON are not null
        jsonResult.forEach((key, value) {
          expect(value, isNotNull, reason: 'Field $key should not be null');
        });

        // Assert
        expect(result, isA<DriverEntity>());
        expect(result.country, equals('Country'));
        expect(result.firstName, equals('John'));
        expect(result.id, equals('driver_123'));
      },
    );

    test(
      'toEntity with null values should return DriverEntity with null fields',
      () {
        // Arrange
        final driver = DriverDto();

        // Act
        final result = driver.convertIntoEntity();
        final jsonResult = driver.toJson();

        // Verify all fields in JSON are null
        jsonResult.forEach((key, value) {
          expect(value, isNull, reason: 'Field $key should be null');
        });

        // Assert
        expect(result, isA<DriverEntity?>());
        expect(result.country, isNull);
        expect(result.firstName, isNull);
        expect(result.id, isNull);
      },
    );
  });

  group('DriverRequestModel', () {
    group('to FormData', () {
      test('toFormData should create FormData with all fields', () async {
        // Arrange
        final tempDir = Directory.systemTemp;
        final nidFile = File('${tempDir.path}/nid.jpg')..createSync();
        final licenseFile = File('${tempDir.path}/license.jpg')..createSync();

        final model = DriverRequestModel(
          country: 'Country',
          firstName: 'John',
          lastName: 'Doe',
          vehicleType: '1',
          vehicleNumber: '123',
          vehicleLicense: licenseFile,
          nid: '123456789',
          nIDImg: nidFile,
          email: 'john@example.com',
          password: 'password',
          rePassword: 'password',
          gender: 'male',
          phone: '1234567890',
        );

        // Act
        final formData = await model.toFormData();

        // Assert
        expect(formData.fields.length, greaterThan(0));
        expect(formData.files.length, equals(2));

        // Clean up
        nidFile.deleteSync();
        licenseFile.deleteSync();
      });

      test('toFormData should throw when required files are missing', () async {
        // Arrange
        final model = DriverRequestModel();
        final jsonResult = model.toJson();

        // Verify all fields in JSON are null
        jsonResult.forEach((key, value) {
          expect(value, isNull, reason: 'Field $key should be null');
        });

        // Act & Assert
        expect(() => model.toFormData(), throwsException);
      });
    });

    group('createMultipartFile', () {
      test(
        'createMultipartFile should create MultipartFile with correct content type',
        () async {
          // Arrange
          final tempDir = Directory.systemTemp;
          final pngFile = File('${tempDir.path}/test.png')..createSync();
          final jpgFile = File('${tempDir.path}/test.jpg')..createSync();
          final model = DriverRequestModel();

          // Act
          final pngMultipart = await model.createMultipartFile(pngFile);
          final jpgMultipart = await model.createMultipartFile(jpgFile);

          // Assert
          expect(pngMultipart.contentType?.mimeType, equals('image/png'));
          expect(jpgMultipart.contentType?.mimeType, equals('image/jpeg'));

          // Clean up
          pngFile.deleteSync();
          jpgFile.deleteSync();
        },
      );
    });
  });
}
