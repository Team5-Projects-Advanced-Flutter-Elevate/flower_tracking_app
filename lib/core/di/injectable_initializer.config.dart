// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../modules/apply/data/api/api_client/apply_api_client.dart' as _i780;
import '../../modules/apply/data/api/api_provider/apply_api_provider.dart'
    as _i594;
import '../../modules/apply/data/datasource_contract/apply_datasource.dart'
    as _i843;
import '../../modules/apply/data/datasource_impl/apply_datasouce_impl.dart'
    as _i684;
import '../../modules/apply/data/repo_impl/apply_repo_impl.dart' as _i792;
import '../../modules/apply/domain/repo_contract/apply_repo_contract.dart'
    as _i61;
import '../../modules/apply/domain/usecases/apply_use_case.dart' as _i637;
import '../../modules/apply/domain/usecases/get_vehicles_use_case.dart'
    as _i900;
import '../../modules/apply/ui/view_model/apply_cubit.dart' as _i172;
import '../../modules/authentication/data/api/api_client/auth_api_client.dart'
    as _i343;
import '../../modules/authentication/data/api/api_client_provider/auth_api_client_provider.dart'
    as _i1019;
import '../../modules/authentication/data/data_sources_contracts/forget_password/forget_password_remote_data_source.dart'
    as _i150;
import '../../modules/authentication/data/data_sources_contracts/forget_password/reset_code_remote_data_source.dart'
    as _i779;
import '../../modules/authentication/data/data_sources_contracts/forget_password/reset_password_remote_data_source.dart'
    as _i881;
import '../../modules/authentication/data/data_sources_contracts/logged_driver_data/logged_drivr_data_remote_data_source.dart'
    as _i504;
import '../../modules/authentication/data/data_sources_contracts/login/local/login_local_data_source.dart'
    as _i34;
import '../../modules/authentication/data/data_sources_contracts/login/remote/login_remote_data_source.dart'
    as _i477;
import '../../modules/authentication/data/data_sources_imp/forget_password/forget_password_remote_data_source_imp.dart'
    as _i191;
import '../../modules/authentication/data/data_sources_imp/forget_password/reset_code_remote_data_source_impl.dart'
    as _i808;
import '../../modules/authentication/data/data_sources_imp/forget_password/reset_password_remote_data_source_impl.dart'
    as _i956;
import '../../modules/authentication/data/data_sources_imp/logged_driver_data/logged_driver_data_remote_data_source_imp.dart'
    as _i493;
import '../../modules/authentication/data/data_sources_imp/login/local/login_local_data_source_imp.dart'
    as _i443;
import '../../modules/authentication/data/data_sources_imp/login/remote/login_remote_data_source_imp.dart'
    as _i120;
import '../../modules/authentication/data/repositories_imp/logged_driver_data/logged_driver_data_repo_imp.dart'
    as _i234;
import '../../modules/authentication/data/repositories_imp/login/login_repo_imp.dart'
    as _i641;
import '../../modules/authentication/data/respositoies_imp/forget_password/forget_password_repo_imp.dart'
    as _i811;
import '../../modules/authentication/data/respositoies_imp/forget_password/reset_code_repo_impl.dart'
    as _i196;
import '../../modules/authentication/data/respositoies_imp/forget_password/reset_password_repo_impl.dart'
    as _i940;
import '../../modules/authentication/domain/repositories_contracts/forget_password/forget_password_repo.dart'
    as _i1013;
import '../../modules/authentication/domain/repositories_contracts/forget_password/reset_code_repo.dart'
    as _i251;
import '../../modules/authentication/domain/repositories_contracts/forget_password/reset_password_repo.dart'
    as _i731;
import '../../modules/authentication/domain/repositories_contracts/logged_driver_data/logged_driver_data_repo.dart'
    as _i103;
import '../../modules/authentication/domain/repositories_contracts/login/login_repo.dart'
    as _i450;
import '../../modules/authentication/domain/use_cases/forget_password/forget_password_use_case.dart'
    as _i823;
import '../../modules/authentication/domain/use_cases/forget_password/reset_code_use_case.dart'
    as _i9;
import '../../modules/authentication/domain/use_cases/forget_password/reset_password_use_case.dart'
    as _i110;
import '../../modules/authentication/domain/use_cases/login/login_use_case.dart'
    as _i543;
import '../../modules/authentication/ui/forget_password/view_model/forget_password_screen_view_model.dart'
    as _i105;
import '../../modules/authentication/ui/login/view_model/login_view_model.dart'
    as _i108;
import '../../modules/home/data/api/api_client/orders_api_client.dart' as _i290;
import '../../modules/home/data/models/orders_client_model.dart' as _i858;
import '../../modules/home/data/repo_impl/orders_repo_impl.dart' as _i823;
import '../../modules/home/domain/repo_contract/orders_repo.dart' as _i544;
import '../../modules/home/domain/use_cases/get_pending_orders_use_case.dart'
    as _i553;
import '../../modules/home/ui/cubit/pending_orders/pending_orders_cubit.dart'
    as _i12;
import '../../shared_layers/localization/generated/app_localizations.dart'
    as _i543;
import '../../shared_layers/localization/initializer/locale_initializer.dart'
    as _i631;
import '../../shared_layers/localization/l10n_manager/localization_manager.dart'
    as _i273;
import '../../shared_layers/storage/contracts/flutter_secure_storage_service_contract.dart'
    as _i629;
import '../../shared_layers/storage/implementation/flutter_secure_storage_service_imp.dart'
    as _i701;
import '../../shared_layers/storage/initializer/storage_initializer.dart'
    as _i241;
import '../apis/api_error/api_error_handler.dart' as _i439;
import '../utilities/app_localizations/app_localizations_provider.dart'
    as _i363;
import '../utilities/dio/dio_service/dio_service.dart' as _i738;
import '../validation/validation_functions.dart' as _i166;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioService = _$DioService();
    final storagesInitializer = _$StoragesInitializer();
    final applyApiClientProvider = _$ApplyApiClientProvider();
    final authApiClientProvider = _$AuthApiClientProvider();
    final ordersApiClientProvider = _$OrdersApiClientProvider();
    final localeInitializer = _$LocaleInitializer();
    final appLocalizationsProvider = _$AppLocalizationsProvider();
    await gh.factoryAsync<_i361.Dio>(
      () => dioService.provideDio(),
      preResolve: true,
    );
    await gh.factoryAsync<_i558.FlutterSecureStorage>(
      () => storagesInitializer.initFlutterSecureStorage(),
      preResolve: true,
    );
    gh.lazySingleton<_i843.ImagePickerService>(
      () => _i684.DefaultImagePickerService(),
    );
    gh.lazySingleton<_i780.ApplyApiClient>(
      () => applyApiClientProvider.providerApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i343.AuthApiClient>(
      () => authApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i858.OrdersApiClient>(
      () => ordersApiClientProvider.providerApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i843.ApplyDataSource>(
      () => _i684.ApplyDataSourceImpl(gh<_i780.ApplyApiClient>()),
    );
    gh.factory<_i881.ResetPasswordRemoteDataSource>(
      () => _i956.ResetPasswordRemoteDataSourceImpl(gh<_i343.AuthApiClient>()),
    );
    gh.lazySingleton<_i843.CountryLoaderService>(
      () => _i684.AssetCountryLoaderService(),
    );
    gh.factory<_i544.OrdersRepo>(
      () => _i823.OrdersRepoImpl(apiClient: gh<_i858.OrdersApiClient>()),
    );
    gh.factory<_i61.ApplyRepo>(
      () => _i792.ApplyRepoImpl(applyDataSource: gh<_i843.ApplyDataSource>()),
    );
    gh.factory<_i731.ResetPasswordRepo>(
      () => _i940.ResetPasswordRepoImpl(
        gh<_i881.ResetPasswordRemoteDataSource>(),
      ),
    );
    gh.singleton<_i629.SecureStorageService<dynamic>>(
      () => _i701.SecureStorageServiceImp(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i477.LoginRemoteDataSource>(
      () => _i120.LoginRemoteDataSourceImp(gh<_i343.AuthApiClient>()),
    );
    gh.factory<_i504.LoggedDriverDataRemoteDataSource>(
      () =>
          _i493.LoggedDriverDataRemoteDataSourceImp(gh<_i343.AuthApiClient>()),
    );
    gh.factory<_i637.ApplyDriverUseCase>(
      () => _i637.ApplyDriverUseCase(gh<_i61.ApplyRepo>()),
    );
    gh.factory<_i900.GetVehiclesUseCase>(
      () => _i900.GetVehiclesUseCase(gh<_i61.ApplyRepo>()),
    );
    gh.factory<_i779.ResetCodeRemoteDataSource>(
      () => _i808.ResetCodeRemoteDataSourceImpl(gh<_i343.AuthApiClient>()),
    );
    gh.factory<_i34.LoginLocalDataSource>(
      () => _i443.LoginLocalDataSourceImp(
        gh<_i629.SecureStorageService<dynamic>>(),
      ),
    );
    gh.factory<_i172.ApplyCubit>(
      () => _i172.ApplyCubit(
        gh<_i637.ApplyDriverUseCase>(),
        gh<_i900.GetVehiclesUseCase>(),
        gh<_i843.CountryLoaderService>(),
        gh<_i843.ImagePickerService>(),
      ),
    );
    gh.factory<_i553.GetPendingOrdersUseCase>(
      () => _i553.GetPendingOrdersUseCase(gh<_i544.OrdersRepo>()),
    );
    gh.factory<_i251.ResetCodeRepo>(
      () => _i196.ResetCodeRepoImpl(gh<_i779.ResetCodeRemoteDataSource>()),
    );
    gh.factory<_i150.ForgetPasswordRemoteDataSource>(
      () => _i191.ForgetPasswordRemoteDataSourceImpl(gh<_i343.AuthApiClient>()),
    );
    await gh.factoryAsync<String>(
      () => localeInitializer.initCurrentLocal(
        gh<_i629.SecureStorageService<dynamic>>(),
      ),
      instanceName: 'initCurrentLocal',
      preResolve: true,
    );
    gh.singleton<_i273.LocalizationManager>(
      () => _i273.LocalizationManager(
        gh<_i629.SecureStorageService<dynamic>>(),
        gh<String>(instanceName: 'initCurrentLocal'),
      ),
    );
    gh.factory<_i9.ResetCodeUseCase>(
      () => _i9.ResetCodeUseCase(gh<_i251.ResetCodeRepo>()),
    );
    gh.factory<_i110.ResetPasswordUseCase>(
      () => _i110.ResetPasswordUseCase(gh<_i731.ResetPasswordRepo>()),
    );
    gh.factory<_i450.LoginRepo>(
      () => _i641.LoginRepoImp(
        gh<_i477.LoginRemoteDataSource>(),
        gh<_i34.LoginLocalDataSource>(),
        gh<_i504.LoggedDriverDataRemoteDataSource>(),
      ),
    );
    gh.factory<_i103.LoggedDriverDataRepo>(
      () => _i234.LoggedDriverDataRepoImp(
        gh<_i504.LoggedDriverDataRemoteDataSource>(),
      ),
    );
    await gh.factoryAsync<_i543.AppLocalizations>(
      () => appLocalizationsProvider.provideAppLocalizations(
        gh<String>(instanceName: 'initCurrentLocal'),
      ),
      preResolve: true,
    );
    gh.lazySingleton<_i12.OrdersCubit>(
      () => _i12.OrdersCubit(gh<_i553.GetPendingOrdersUseCase>()),
    );
    gh.factory<_i543.LoginUseCase>(
      () => _i543.LoginUseCase(gh<_i450.LoginRepo>()),
    );
    gh.factory<_i1013.ForgetPasswordRepo>(
      () => _i811.ForgetPasswordRepoImpl(
        gh<_i150.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i166.ValidateFunctions>(
      () => _i166.ValidateFunctions(gh<_i543.AppLocalizations>()),
    );
    gh.lazySingleton<_i439.ApiErrorHandler>(
      () => _i439.ApiErrorHandler(gh<_i543.AppLocalizations>()),
    );
    gh.factory<_i823.ForgetPasswordUseCase>(
      () => _i823.ForgetPasswordUseCase(gh<_i1013.ForgetPasswordRepo>()),
    );
    gh.factory<_i108.LoginViewModel>(
      () => _i108.LoginViewModel(gh<_i543.LoginUseCase>()),
    );
    gh.factory<_i105.ForgetPasswordViewModel>(
      () => _i105.ForgetPasswordViewModel(
        gh<_i823.ForgetPasswordUseCase>(),
        gh<_i110.ResetPasswordUseCase>(),
        gh<_i9.ResetCodeUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioService extends _i738.DioService {}

class _$StoragesInitializer extends _i241.StoragesInitializer {}

class _$ApplyApiClientProvider extends _i594.ApplyApiClientProvider {}

class _$AuthApiClientProvider extends _i1019.AuthApiClientProvider {}

class _$OrdersApiClientProvider extends _i290.OrdersApiClientProvider {}

class _$LocaleInitializer extends _i631.LocaleInitializer {}

class _$AppLocalizationsProvider extends _i363.AppLocalizationsProvider {}
