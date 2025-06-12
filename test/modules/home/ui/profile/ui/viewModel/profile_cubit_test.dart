import 'package:bloc_test/bloc_test.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/use_cases/logged_driver_data/get_logged_driver_data_use_case.dart';
import 'package:flower_tracking_app/modules/home/ui/profile/ui/viewModel/profile_cubit.dart';
import 'package:flower_tracking_app/modules/logout/domain/use_cases/logout/logout_use_case.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/driver/driver_entity_firestore.dart';
import 'package:flower_tracking_app/shared_layers/localization/l10n_manager/localization_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([GetLoggedDriverDataUseCase, LocalizationManager, LogoutUseCase])
void main() {
  late MockGetLoggedDriverDataUseCase mockGetLoggedDriverDataUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late ProfileCubit profileCubit;
  late LoggedDriverDataResponseEntity loggedDriverDataResponseEntity;
  late Object exception;

  setUp(() {
    mockGetLoggedDriverDataUseCase = MockGetLoggedDriverDataUseCase();
    mockLogoutUseCase = MockLogoutUseCase();

    profileCubit = ProfileCubit(
      mockGetLoggedDriverDataUseCase,
      mockLogoutUseCase,
    );

    loggedDriverDataResponseEntity = LoggedDriverDataResponseEntity(
      message: "Success",
      driver: DriverEntityFirestore(
        id: "1",
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@example.com",
        phone: "+1234567890",
        country: "USA",
        vehicleType: "Truck",
        vehicleNumber: "ABC123",
      ),
      token: "token123",
    );

    exception = Exception('Test exception');
  });

  group('ProfileCubit', () {
    test('initial state', () {
      expect(profileCubit.state, const ProfileState());
    });

    group('loadProfileData', () {
      blocTest<ProfileCubit, ProfileState>(
        'emits [loading, success] states when profile data is loaded successfully',
        build: () => profileCubit,
        setUp: () {
          provideDummy<ApiResult<LoggedDriverDataResponseEntity>>(
            Success<LoggedDriverDataResponseEntity>(
              data: loggedDriverDataResponseEntity,
            ),
          );
          when(mockGetLoggedDriverDataUseCase.call()).thenAnswer(
            (_) async => Success(data: loggedDriverDataResponseEntity),
          );
        },
        act: (cubit) => cubit.doIntent(LoadProfileIntent()),
        expect:
            () => [
              const ProfileState(loadProfileStatus: LoadProfileStatus.loading),
              ProfileState(
                loadProfileStatus: LoadProfileStatus.success,
                loggedDriverDataResponseEntity: loggedDriverDataResponseEntity,
              ),
            ],
      );

      blocTest<ProfileCubit, ProfileState>(
        'emits [loading, error] states when profile data loading fails',
        build: () => profileCubit,
        setUp: () {
          provideDummy<ApiResult<LoggedDriverDataResponseEntity>>(
            Error<LoggedDriverDataResponseEntity>(error: exception),
          );
          when(
            mockGetLoggedDriverDataUseCase.call(),
          ).thenAnswer((_) async => Error(error: exception));
        },
        act: (cubit) => cubit.doIntent(LoadProfileIntent()),
        expect:
            () => [
              const ProfileState(loadProfileStatus: LoadProfileStatus.loading),
              ProfileState(
                loadProfileStatus: LoadProfileStatus.error,
                loadProfileError: exception,
              ),
            ],
      );
    });
  });
}
