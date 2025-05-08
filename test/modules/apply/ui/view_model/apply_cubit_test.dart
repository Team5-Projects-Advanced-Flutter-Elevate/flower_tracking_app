import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/apply/data/datasource_contract/apply_datasource.dart';
import 'package:flower_tracking_app/modules/apply/data/models/apply_response.dart';
import 'package:flower_tracking_app/modules/apply/data/models/country_model.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/usecases/apply_use_case.dart';
import 'package:flower_tracking_app/modules/apply/domain/usecases/get_vehicles_use_case.dart';
import 'package:flower_tracking_app/modules/apply/ui/view_model/apply_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'apply_cubit_test.mocks.dart';

@GenerateMocks([
  ApplyDriverUseCase,
  GetVehiclesUseCase,
  CountryLoaderService,
  ImagePickerService,
])
void main() {
  late MockApplyDriverUseCase mockApplyDriverUseCase;
  late MockGetVehiclesUseCase mockGetVehiclesUseCase;
  late MockCountryLoaderService mockCountryLoaderService;
  late MockImagePickerService mockImagePickerService;
  late ApplyCubit applyCubit;
  late Object exception;
  late ApplyState state;

  group('ApplyCubit', () {
    setUp(() {
      mockApplyDriverUseCase = MockApplyDriverUseCase();
      mockGetVehiclesUseCase = MockGetVehiclesUseCase();
      mockCountryLoaderService = MockCountryLoaderService();
      mockImagePickerService = MockImagePickerService();
      state = const ApplyState();

      applyCubit = ApplyCubit(
        mockApplyDriverUseCase,
        mockGetVehiclesUseCase,
        mockCountryLoaderService,
        mockImagePickerService,
      );

      exception = Exception('Test exception');
    });

    test('initial state', () {
      expect(applyCubit.state, state);
    });

    group('load countries', () {
      blocTest(
        'loadCountries success',
        build: () => applyCubit,
        setUp: () {
          when(
            mockCountryLoaderService.loadCountryJson(),
          ).thenAnswer((_) async => '[{"name": "Country A", "isoCode": "CA"}]');
        },
        act: (cubit) => cubit.doIntent(LoadCountriesIntent()),
        expect:
            () => [
              state.copyWith(loadCountryStatus: LoadCountryStatus.loading),
              state.copyWith(
                loadCountryStatus: LoadCountryStatus.success,
                countries: [
                  const CountryModel(name: 'Country A', isoCode: 'CA'),
                ],
              ),
            ],
      );

      blocTest(
        'loadCountries error',
        build: () => applyCubit,
        setUp: () {
          when(mockCountryLoaderService.loadCountryJson()).thenThrow(exception);
        },
        act: (cubit) => cubit.doIntent(LoadCountriesIntent()),
        expect:
            () => [
              state.copyWith(loadCountryStatus: LoadCountryStatus.loading),
              state.copyWith(
                loadCountryStatus: LoadCountryStatus.error,
                loadCountryError: exception,
              ),
            ],
      );
    });

    group('load Vehicles', () {
      late VehicleResponseEntity vehicleResponseEntity;
      blocTest(
        'loadVehicles success',
        build: () => applyCubit,
        setUp: () {
          vehicleResponseEntity = const VehicleResponseEntity(
            vehicles: [
              VehicleEntity(id: 'veh_123', type: 'Truck', image: 'truck.jpg'),
            ],
          );
          provideDummy<ApiResult<VehicleResponseEntity>>(
            Success<VehicleResponseEntity>(data: vehicleResponseEntity),
          );
          when(mockGetVehiclesUseCase.execute()).thenAnswer(
            (_) async =>
                Success<VehicleResponseEntity>(data: vehicleResponseEntity),
          );
        },
        act: (cubit) => cubit.doIntent(LoadVehiclesIntent()),
        expect:
            () => [
              state.copyWith(loadVehicleStatus: LoadVehicleStatus.loading),
              state.copyWith(
                loadVehicleStatus: LoadVehicleStatus.success,
                vehicles: [
                  const VehicleEntity(
                    id: 'veh_123',
                    type: 'Truck',
                    image: 'truck.jpg',
                  ),
                ],
              ),
            ],
      );

      blocTest(
        'loadVehicles error',
        build: () => applyCubit,
        setUp: () {
          when(mockGetVehiclesUseCase.execute()).thenAnswer(
            (_) async => Error<VehicleResponseEntity>(error: exception),
          );
        },
        act: (cubit) => cubit.doIntent(LoadVehiclesIntent()),
        expect:
            () => [
              state.copyWith(loadVehicleStatus: LoadVehicleStatus.loading),
              state.copyWith(
                loadVehicleStatus: LoadVehicleStatus.error,
                loadVehicleError: exception,
              ),
            ],
      );
    });

    group('apply driver ', () {
      late ApplyResponseEntity applyResponseEntity;
      blocTest(
        'applyDriver success',
        build: () => applyCubit,
        setUp: () {
          applyResponseEntity = const ApplyResponseEntity();
          provideDummy<ApiResult<ApplyResponseEntity>>(
            Success<ApplyResponseEntity>(data: applyResponseEntity),
          );
          when(mockApplyDriverUseCase.execute(any)).thenAnswer(
            (_) async =>
                Success<ApplyResponseEntity>(data: applyResponseEntity),
          );
        },
        act:
            (cubit) => cubit.doIntent(
              ApplyDriverIntent(
                DriverRequestModel(
                  vehicleType: '1',
                  nIDImg: null,
                  vehicleLicense: null,
                ),
              ),
            ),
        expect:
            () => [
              state.copyWith(applyDriverStatus: ApplyDriverStatus.loading),
              state.copyWith(applyDriverStatus: ApplyDriverStatus.success),
            ],
      );

      blocTest(
        'applyDriver error',
        build: () => applyCubit,
        setUp: () {
          when(mockApplyDriverUseCase.execute(any)).thenAnswer(
            (_) async => Error<ApplyResponseEntity>(error: exception),
          );
        },
        act:
            (cubit) => cubit.doIntent(
              ApplyDriverIntent(
                DriverRequestModel(
                  vehicleType: '1',
                  nIDImg: null,
                  vehicleLicense: null,
                ),
              ),
            ),
        expect:
            () => [
              state.copyWith(applyDriverStatus: ApplyDriverStatus.loading),
              state.copyWith(
                applyDriverStatus: ApplyDriverStatus.error,
                applyDriverError: exception,
              ),
            ],
      );
    });

    blocTest(
      'selectCountry',
      build: () => applyCubit,
      act: (cubit) => cubit.doIntent(SelectCountryIntent('Egypt')),
      expect:
          () => [
            const ApplyState(
              selectedCountry: 'Egypt',
              applyDriverStatus: ApplyDriverStatus.initial,
              pickImageStatus: PickImageStatus.initial,
            ),
          ],
    );

    blocTest(
      'selectVehicle',
      build: () => applyCubit,
      act:
          (cubit) => cubit.doIntent(
            SelectVehicleIntent(const VehicleEntity(id: '1', type: 'Truck')),
          ),
      expect:
          () => [
            const ApplyState(
              selectedVehicle: VehicleEntity(id: '1', type: 'Truck'),
              applyDriverStatus: ApplyDriverStatus.initial,
              pickImageStatus: PickImageStatus.initial,
            ),
          ],
    );

    blocTest(
      'selectGender',
      build: () => applyCubit,
      act: (cubit) => cubit.doIntent(SelectGenderIntent('male')),
      expect:
          () => [
            const ApplyState(
              selectedGender: 'male',
              applyDriverStatus: ApplyDriverStatus.initial,
              pickImageStatus: PickImageStatus.initial,
            ),
          ],
    );

    group('pick image', () {
      blocTest(
        'pick image',
        build: () => applyCubit,
        act: (cubit) => cubit.doIntent(PickImageIntent()),
        setUp: () {
          when(
            mockImagePickerService.pickImageFromGallery(),
          ).thenAnswer((_) async => File('dummy/path/image.png'));
        },

        expect:
            () => [
              state.copyWith(pickImageStatus: PickImageStatus.loading),
              state.copyWith(
                pickImageStatus: PickImageStatus.success,
                applyDriverStatus: ApplyDriverStatus.initial,
              ),
            ],
      );

      blocTest(
        'pick image error',
        build: () => applyCubit,
        act: (cubit) => cubit.doIntent(PickImageIntent()),
        setUp: () {
          when(
            mockImagePickerService.pickImageFromGallery(),
          ).thenThrow(exception);
        },
        expect:
            () => [
              state.copyWith(pickImageStatus: PickImageStatus.loading),
              state.copyWith(
                pickImageStatus: PickImageStatus.error,
                pickImageError: exception,
                applyDriverStatus: ApplyDriverStatus.initial,
              ),
            ],
      );
    });

    group('un pick image ', () {
      late bool isLicenseImagePicked;
      setUp(() {
        isLicenseImagePicked = true;
      });
      blocTest(
        'un pick license image',
        build: () => applyCubit,

        act: (cubit) => cubit.doIntent(UnPickImageIntent(isLicenseImagePicked)),
        expect:
            () => [
              const ApplyState(
                pickedLicenseImage: null,
                isLicenseImagePicked: false,
                pickImageStatus: PickImageStatus.unPicked,
                applyDriverStatus: ApplyDriverStatus.initial,
              ),
            ],
      );

      blocTest(
        'un pick id image',
        build: () => applyCubit,
        act:
            (cubit) => cubit.doIntent(UnPickImageIntent(!isLicenseImagePicked)),
        expect:
            () => [
              const ApplyState(
                pickedIdImage: null,
                isIdImagePicked: false,
                pickImageStatus: PickImageStatus.unPicked,
                applyDriverStatus: ApplyDriverStatus.initial,
              ),
            ],
      );
    });

    group('pick id image ', () {
      File pickedImage = File('dummy/path/image.png');
      blocTest(
        'pick id image success ',
        build: () => applyCubit,
        act: (cubit) async => cubit.doIntent(PickIdImageIntent()),
        setUp: () {
          when(
            mockImagePickerService.pickImageFromGallery(),
          ).thenAnswer((_) async => pickedImage);
        },
        expect:
            () => [
              state.copyWith(pickImageStatus: PickImageStatus.loading),
              state.copyWith(pickImageStatus: PickImageStatus.success),
              state.copyWith(
                pickedIdImage: pickedImage,
                pickImageStatus: PickImageStatus.success,
                isIdImagePicked: true,
                applyDriverStatus: ApplyDriverStatus.initial,
              ),
            ],
      );

      blocTest(
        'pick id image error',
        build: () => applyCubit,
        act: (cubit) => cubit.doIntent(PickIdImageIntent()),
        setUp: () {
          when(
            mockImagePickerService.pickImageFromGallery(),
          ).thenThrow(exception);
        },
        expect:
            () => [
              state.copyWith(pickImageStatus: PickImageStatus.loading),
              state.copyWith(
                pickImageStatus: PickImageStatus.error,
                pickImageError: exception,
                applyDriverStatus: ApplyDriverStatus.initial,
              ),
            ],
      );
    });

    group('pick license image ', () {
      File pickedImage = File('dummy/path/image.png');
      blocTest(
        'pick license image success ',
        build: () => applyCubit,
        act: (cubit) async => cubit.doIntent(PickLicenseImageIntent()),
        setUp: () {
          when(
            mockImagePickerService.pickImageFromGallery(),
          ).thenAnswer((_) async => pickedImage);
        },
        expect:
            () => [
              state.copyWith(pickImageStatus: PickImageStatus.loading),
              state.copyWith(pickImageStatus: PickImageStatus.success),
              state.copyWith(
                pickImageStatus: PickImageStatus.success,
                pickedLicenseImage: pickedImage,
                isLicenseImagePicked: true,
                applyDriverStatus: ApplyDriverStatus.initial,
              ),
            ],
      );

      blocTest(
        'pick license image error',
        build: () => applyCubit,
        act: (cubit) => cubit.doIntent(PickLicenseImageIntent()),
        setUp: () {
          when(
            mockImagePickerService.pickImageFromGallery(),
          ).thenThrow(exception);
        },
        expect:
            () => [
              state.copyWith(pickImageStatus: PickImageStatus.loading),
              state.copyWith(
                pickImageStatus: PickImageStatus.error,
                pickImageError: exception,
                applyDriverStatus: ApplyDriverStatus.initial,
              ),
            ],
      );
    });
  });
}
