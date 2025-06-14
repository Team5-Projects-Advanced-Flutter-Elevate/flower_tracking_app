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
import '../../modules/authentication/domain/use_cases/logged_driver_data/get_logged_driver_data_use_case.dart'
    as _i211;
import '../../modules/authentication/domain/use_cases/login/login_use_case.dart'
    as _i543;
import '../../modules/authentication/ui/forget_password/view_model/forget_password_screen_view_model.dart'
    as _i105;
import '../../modules/authentication/ui/login/view_model/login_view_model.dart'
    as _i108;
import '../../modules/edit_profile/data/api/api_client/get_data_api_client.dart'
    as _i984;
import '../../modules/edit_profile/data/api/api_client/upload_image_api_client.dart'
    as _i737;
import '../../modules/edit_profile/data/api/api_client_provider/get_data_api_client_provider.dart'
    as _i1073;
import '../../modules/edit_profile/data/datasource/change_password.dart'
    as _i329;
import '../../modules/edit_profile/data/datasource/edit_info.dart' as _i229;
import '../../modules/edit_profile/data/datasource/get_data.dart' as _i890;
import '../../modules/edit_profile/data/datasource/upload_image.dart' as _i754;
import '../../modules/edit_profile/data/datasource_impl/change_password.dart'
    as _i720;
import '../../modules/edit_profile/data/datasource_impl/edit_info.dart' as _i93;
import '../../modules/edit_profile/data/datasource_impl/get_data.dart' as _i458;
import '../../modules/edit_profile/data/datasource_impl/upload_image.dart'
    as _i626;
import '../../modules/edit_profile/data/repo_impl/change_password.dart' as _i97;
import '../../modules/edit_profile/data/repo_impl/edit_info.dart' as _i213;
import '../../modules/edit_profile/data/repo_impl/get_data.dart' as _i452;
import '../../modules/edit_profile/data/repo_impl/image_upload.dart' as _i42;
import '../../modules/edit_profile/domain/repo/change_password.dart' as _i724;
import '../../modules/edit_profile/domain/repo/edit_data.dart' as _i272;
import '../../modules/edit_profile/domain/repo/get_data_repo.dart' as _i382;
import '../../modules/edit_profile/domain/repo/upload_image.dart' as _i51;
import '../../modules/edit_profile/domain/usecase/change_password_usecase.dart'
    as _i165;
import '../../modules/edit_profile/domain/usecase/edit_info_usecase.dart'
    as _i797;
import '../../modules/edit_profile/domain/usecase/get_data_usecase.dart'
    as _i736;
import '../../modules/edit_profile/domain/usecase/upload_image.dart' as _i875;
import '../../modules/edit_profile/ui/cubit/view_model.dart' as _i552;
import '../../modules/edit_vehicle_info/data/api/api_client/vehicle_api_client.dart'
    as _i548;
import '../../modules/edit_vehicle_info/data/api/api_provider/vehicle_api_provider.dart'
    as _i1043;
import '../../modules/edit_vehicle_info/data/datasource_contract/vehicle_datasource.dart'
    as _i789;
import '../../modules/edit_vehicle_info/data/datasource_impl/vehicle_datasouce_impl.dart'
    as _i981;
import '../../modules/edit_vehicle_info/data/repo_impl/vehicle_repo_impl.dart'
    as _i845;
import '../../modules/edit_vehicle_info/domain/repo_contract/vehicle_repo_contract.dart'
    as _i898;
import '../../modules/edit_vehicle_info/domain/usecases/edit_vehicle_use_case.dart'
    as _i799;
import '../../modules/edit_vehicle_info/domain/usecases/get_vehicle_by_id_use_case.dart'
    as _i172;
import '../../modules/edit_vehicle_info/domain/usecases/get_vehicles_use_case.dart'
    as _i72;
import '../../modules/edit_vehicle_info/ui/view_model/vehicle_cubit.dart'
    as _i212;
import '../../modules/home/data/api/api_client/orders_api_client.dart' as _i290;
import '../../modules/home/data/api/api_driver/order_api_driver.dart' as _i47;
import '../../modules/home/data/models/driver/pending_orders_model.dart'
    as _i433;
import '../../modules/home/data/models/orders_client_model.dart' as _i858;
import '../../modules/home/data/repo_impl/driver/orders_repo_impl.dart'
    as _i335;
import '../../modules/home/data/repo_impl/orders_repo_impl.dart' as _i823;
import '../../modules/home/domain/repo_contract/driver/orders_repo.dart'
    as _i245;
import '../../modules/home/domain/repo_contract/orders_repo.dart' as _i544;
import '../../modules/home/domain/use_cases/driver/get_pending_orders_use_case.dart'
    as _i827;
import '../../modules/home/domain/use_cases/get_pending_orders_use_case.dart'
    as _i553;
import '../../modules/home/ui/cubit/driver/pending_orders/pending_orders_cubit.dart'
    as _i795;
import '../../modules/home/ui/cubit/pending_orders/pending_orders_cubit.dart'
    as _i12;
import '../../modules/home/ui/profile/ui/viewModel/profile_cubit.dart' as _i792;
import '../../modules/logout/data/api/api_client/logout_api_client.dart'
    as _i877;
import '../../modules/logout/data/api/api_client_provider/logout_api_client_provider.dart'
    as _i894;
import '../../modules/logout/data/data_sources_contracts/logout/logout_remote_data_source.dart'
    as _i774;
import '../../modules/logout/data/data_sources_imp/logout/logout_remote_data_source_imp.dart'
    as _i892;
import '../../modules/logout/data/repositories_imp/logout/logout_repo_imp.dart'
    as _i398;
import '../../modules/logout/domain/repositories_contracts/logout/logout_repo.dart'
    as _i607;
import '../../modules/logout/domain/use_cases/logout/logout_use_case.dart'
    as _i56;
import '../../modules/order_details/view_model/order_details_view_model.dart'
    as _i240;
import '../../modules/whatsapp_call/data/data_source/call_data_source.dart'
    as _i692;
import '../../modules/whatsapp_call/data/data_source/whatsapp_data_source.dart'
    as _i1028;
import '../../modules/whatsapp_call/data/data_source_impl/call_data_source_impl.dart'
    as _i787;
import '../../modules/whatsapp_call/data/data_source_impl/whatsapp_data_source_impl.dart'
    as _i882;
import '../../modules/whatsapp_call/data/repo_impl/call_repo_impl.dart'
    as _i618;
import '../../modules/whatsapp_call/data/repo_impl/whatsapp_repo_impl.dart'
    as _i194;
import '../../modules/whatsapp_call/domain/repo/call_repo.dart' as _i557;
import '../../modules/whatsapp_call/domain/repo/whatsapp_repo.dart' as _i281;
import '../../modules/whatsapp_call/domain/usecase/call_usecase.dart' as _i487;
import '../../modules/whatsapp_call/domain/usecase/whatsapp_usecase.dart'
    as _i565;
import '../../modules/whatsapp_call/ui/cubit/launcher_view_model.dart' as _i898;
import '../../shared_layers/database/firestore/data/data_sources_abstracts/driver/driver_collection.dart'
    as _i163;
import '../../shared_layers/database/firestore/data/data_sources_abstracts/order/order_collection.dart'
    as _i793;
import '../../shared_layers/database/firestore/data/data_sources_imp/driver/driver_collection_imp.dart'
    as _i1045;
import '../../shared_layers/database/firestore/data/data_sources_imp/order/order_collection_imp.dart'
    as _i529;
import '../../shared_layers/database/firestore/data/repositories_imp/firestore_repo_imp.dart'
    as _i271;
import '../../shared_layers/database/firestore/domain/repositories_abstracts/firestore_repo_contract.dart'
    as _i261;
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
    final vehicleApiClientProvider = _$VehicleApiClientProvider();
    final ordersApiClientProvider = _$OrdersApiClientProvider();
    final getDataApiClientProvider = _$GetDataApiClientProvider();
    final ordersApiDriverProvider = _$OrdersApiDriverProvider();
    final logoutApiClientProvider = _$LogoutApiClientProvider();
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
    gh.factory<_i163.DriverCollection>(() => _i1045.DriverCollectionImp());
    gh.factory<_i793.OrderCollection>(() => _i529.OrderCollectionImp());
    gh.lazySingleton<_i789.ImagePickerService>(
      () => _i981.DefaultImagePickerService(),
    );
    gh.factory<_i1028.WhatsAppDataSource>(() => _i882.WhatsAppDataSourceImpl());
    gh.lazySingleton<_i843.ImagePickerService>(
      () => _i684.DefaultImagePickerService(),
    );
    gh.factory<_i692.CallDataSource>(() => _i787.CallDataSourceImpl());
    gh.lazySingleton<_i780.ApplyApiClient>(
      () => applyApiClientProvider.providerApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i343.AuthApiClient>(
      () => authApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i548.VehicleApiClient>(
      () => vehicleApiClientProvider.providerApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i858.OrdersApiClient>(
      () => ordersApiClientProvider.providerApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i737.UploadImageApiClient>(
      () => _i737.UploadImageApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i984.GetDataApiClient>(
      () => getDataApiClientProvider.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i433.OrdersRemoteDataSource>(
      () => ordersApiDriverProvider.providerApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i877.LogoutApiClient>(
      () => logoutApiClientProvider.provideClient(gh<_i361.Dio>()),
    );
    gh.factory<_i843.ApplyDataSource>(
      () => _i684.ApplyDataSourceImpl(gh<_i780.ApplyApiClient>()),
    );
    gh.factory<_i329.ChangePasswordOnlineDataSource>(
      () => _i720.ChangePasswordOnlineDataSourceImpl(
        gh<_i984.GetDataApiClient>(),
      ),
    );
    gh.factory<_i557.CallRepo>(
      () => _i618.CallRepoImpl(gh<_i692.CallDataSource>()),
    );
    gh.factory<_i789.VehicleDataSource>(
      () => _i981.VehicleDataSourceImpl(gh<_i548.VehicleApiClient>()),
    );
    gh.factory<_i881.ResetPasswordRemoteDataSource>(
      () => _i956.ResetPasswordRemoteDataSourceImpl(gh<_i343.AuthApiClient>()),
    );
    gh.factory<_i754.UploadImageOnlineDataSource>(
      () => _i626.UploadImageOnlineDataSourceImpl(
        gh<_i737.UploadImageApiClient>(),
      ),
    );
    gh.factory<_i245.OrdersRepo>(
      () => _i335.OrdersRepositoryImpl(gh<_i433.OrdersRemoteDataSource>()),
    );
    gh.lazySingleton<_i843.CountryLoaderService>(
      () => _i684.AssetCountryLoaderService(),
    );
    gh.factory<_i544.OrdersRepo>(
      () => _i823.OrdersRepoImpl(apiClient: gh<_i858.OrdersApiClient>()),
    );
    gh.factory<_i898.VehicleRepo>(
      () => _i845.VehicleRepoImpl(
        vehicleDataSource: gh<_i789.VehicleDataSource>(),
      ),
    );
    gh.factory<_i487.CallUseCase>(
      () => _i487.CallUseCase(gh<_i557.CallRepo>()),
    );
    gh.factory<_i281.WhatsAppRepo>(
      () => _i194.WhatsAppRepoImpl(gh<_i1028.WhatsAppDataSource>()),
    );
    gh.factory<_i731.ResetPasswordRepo>(
      () => _i940.ResetPasswordRepoImpl(
        gh<_i881.ResetPasswordRemoteDataSource>(),
      ),
    );
    gh.singleton<_i629.SecureStorageService<dynamic>>(
      () => _i701.SecureStorageServiceImp(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i827.GetPendingOrdersUseCase>(
      () => _i827.GetPendingOrdersUseCase(gh<_i245.OrdersRepo>()),
    );
    gh.factory<_i261.FirestoreRepoContract>(
      () => _i271.FirestoreRepoImp(
        gh<_i163.DriverCollection>(),
        gh<_i793.OrderCollection>(),
      ),
    );
    gh.factory<_i890.GetLoggedDriverDataOnlineDataSource>(
      () => _i458.GetLoggedDriverDataOnlineDataSourceImpl(
        gh<_i984.GetDataApiClient>(),
      ),
    );
    gh.factory<_i774.LogoutRemoteDataSource>(
      () => _i892.LogoutRemoteDataSourceImp(gh<_i877.LogoutApiClient>()),
    );
    gh.factory<_i477.LoginRemoteDataSource>(
      () => _i120.LoginRemoteDataSourceImp(gh<_i343.AuthApiClient>()),
    );
    gh.factory<_i72.GetVehiclesUseCase>(
      () => _i72.GetVehiclesUseCase(gh<_i898.VehicleRepo>()),
    );
    gh.factory<_i504.LoggedDriverDataRemoteDataSource>(
      () =>
          _i493.LoggedDriverDataRemoteDataSourceImp(gh<_i343.AuthApiClient>()),
    );
    gh.factory<_i61.VehicleRepo>(
      () => _i792.ApplyRepoImpl(
        applyDataSource: gh<_i843.ApplyDataSource>(),
        driverCollection: gh<_i163.DriverCollection>(),
      ),
    );
    gh.factory<_i779.ResetCodeRemoteDataSource>(
      () => _i808.ResetCodeRemoteDataSourceImpl(gh<_i343.AuthApiClient>()),
    );
    gh.factory<_i724.ChangePasswordRepo>(
      () => _i97.ChangePasswordRepoImpl(
        gh<_i329.ChangePasswordOnlineDataSource>(),
      ),
    );
    gh.factory<_i51.UploadImageRepo>(
      () => _i42.UploadImageRepoImpl(gh<_i754.UploadImageOnlineDataSource>()),
    );
    gh.factory<_i229.EditInfoOnlineDataSource>(
      () => _i93.EditInfoOnlineDataSourceImpl(gh<_i984.GetDataApiClient>()),
    );
    gh.factory<_i799.EditeVehicleUseCase>(
      () => _i799.EditeVehicleUseCase(gh<_i898.VehicleRepo>()),
    );
    gh.factory<_i172.GetVehicleByIdUseCase>(
      () => _i172.GetVehicleByIdUseCase(gh<_i898.VehicleRepo>()),
    );
    gh.factory<_i34.LoginLocalDataSource>(
      () => _i443.LoginLocalDataSourceImp(
        gh<_i629.SecureStorageService<dynamic>>(),
      ),
    );
    gh.factory<_i553.GetPendingOrdersUseCase>(
      () => _i553.GetPendingOrdersUseCase(gh<_i544.OrdersRepo>()),
    );
    gh.factory<_i251.ResetCodeRepo>(
      () => _i196.ResetCodeRepoImpl(gh<_i779.ResetCodeRemoteDataSource>()),
    );
    gh.factory<_i382.GetLoggedDriverDataRepo>(
      () => _i452.LoggedDriverDataRepoImp(
        gh<_i890.GetLoggedDriverDataOnlineDataSource>(),
      ),
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
    gh.lazySingleton<_i212.VehicleCubit>(
      () => _i212.VehicleCubit(
        gh<_i799.EditeVehicleUseCase>(),
        gh<_i72.GetVehiclesUseCase>(),
        gh<_i843.ImagePickerService>(),
        gh<_i172.GetVehicleByIdUseCase>(),
      ),
    );
    gh.factory<_i9.ResetCodeUseCase>(
      () => _i9.ResetCodeUseCase(gh<_i251.ResetCodeRepo>()),
    );
    gh.lazySingleton<_i795.OrdersCubit>(
      () => _i795.OrdersCubit(gh<_i827.GetPendingOrdersUseCase>()),
    );
    gh.factory<_i165.ChangePasswordUseCase>(
      () => _i165.ChangePasswordUseCase(gh<_i724.ChangePasswordRepo>()),
    );
    gh.factory<_i110.ResetPasswordUseCase>(
      () => _i110.ResetPasswordUseCase(gh<_i731.ResetPasswordRepo>()),
    );
    gh.factory<_i607.LogoutRepo>(
      () => _i398.LogoutRepoImp(gh<_i774.LogoutRemoteDataSource>()),
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
    gh.factory<_i211.GetLoggedDriverDataUseCase>(
      () => _i211.GetLoggedDriverDataUseCase(gh<_i103.LoggedDriverDataRepo>()),
    );
    await gh.factoryAsync<_i543.AppLocalizations>(
      () => appLocalizationsProvider.provideAppLocalizations(
        gh<String>(instanceName: 'initCurrentLocal'),
      ),
      preResolve: true,
    );
    gh.factory<_i565.WhatsAppUseCase>(
      () => _i565.WhatsAppUseCase(gh<_i281.WhatsAppRepo>()),
    );
    gh.factory<_i56.LogoutUseCase>(
      () => _i56.LogoutUseCase(gh<_i607.LogoutRepo>()),
    );
    gh.factory<_i240.OrderDetailsViewModel>(
      () => _i240.OrderDetailsViewModel(
        gh<_i261.FirestoreRepoContract>(),
        gh<_i629.SecureStorageService<dynamic>>(),
      ),
    );
    gh.lazySingleton<_i12.OrdersCubit>(
      () => _i12.OrdersCubit(
        gh<_i553.GetPendingOrdersUseCase>(),
        gh<_i261.FirestoreRepoContract>(),
        gh<_i629.SecureStorageService<dynamic>>(),
      ),
    );
    gh.factory<_i736.GetDriverDataUseCase>(
      () => _i736.GetDriverDataUseCase(gh<_i382.GetLoggedDriverDataRepo>()),
    );
    gh.factory<_i875.UploadImageUseCase>(
      () => _i875.UploadImageUseCase(gh<_i51.UploadImageRepo>()),
    );
    gh.factory<_i637.ApplyDriverUseCase>(
      () => _i637.ApplyDriverUseCase(gh<_i61.VehicleRepo>()),
    );
    gh.factory<_i900.GetVehiclesUseCase>(
      () => _i900.GetVehiclesUseCase(gh<_i61.VehicleRepo>()),
    );
    gh.factory<_i272.EditInfoRepo>(
      () => _i213.EditInfoRepoImpl(gh<_i229.EditInfoOnlineDataSource>()),
    );
    gh.factory<_i543.LoginUseCase>(
      () => _i543.LoginUseCase(gh<_i450.LoginRepo>()),
    );
    gh.lazySingleton<_i792.ProfileCubit>(
      () => _i792.ProfileCubit(
        gh<_i211.GetLoggedDriverDataUseCase>(),
        gh<_i56.LogoutUseCase>(),
      ),
    );
    gh.factory<_i1013.ForgetPasswordRepo>(
      () => _i811.ForgetPasswordRepoImpl(
        gh<_i150.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i172.ApplyCubit>(
      () => _i172.ApplyCubit(
        gh<_i637.ApplyDriverUseCase>(),
        gh<_i900.GetVehiclesUseCase>(),
        gh<_i843.CountryLoaderService>(),
        gh<_i843.ImagePickerService>(),
      ),
    );
    gh.lazySingleton<_i439.ApiErrorHandler>(
      () => _i439.ApiErrorHandler(gh<_i543.AppLocalizations>()),
    );
    gh.lazySingleton<_i166.ValidateFunctions>(
      () => _i166.ValidateFunctions(gh<_i543.AppLocalizations>()),
    );
    gh.factory<_i898.LauncherViewModel>(
      () => _i898.LauncherViewModel(
        gh<_i565.WhatsAppUseCase>(),
        gh<_i487.CallUseCase>(),
      ),
    );
    gh.factory<_i797.EditInfoUseCase>(
      () => _i797.EditInfoUseCase(gh<_i272.EditInfoRepo>()),
    );
    gh.factory<_i823.ForgetPasswordUseCase>(
      () => _i823.ForgetPasswordUseCase(gh<_i1013.ForgetPasswordRepo>()),
    );
    gh.factory<_i108.LoginViewModel>(
      () => _i108.LoginViewModel(gh<_i543.LoginUseCase>()),
    );
    gh.factory<_i552.EditProfileViewModel>(
      () => _i552.EditProfileViewModel(
        gh<_i736.GetDriverDataUseCase>(),
        gh<_i797.EditInfoUseCase>(),
        gh<_i875.UploadImageUseCase>(),
        gh<_i165.ChangePasswordUseCase>(),
      ),
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

class _$VehicleApiClientProvider extends _i1043.VehicleApiClientProvider {}

class _$OrdersApiClientProvider extends _i290.OrdersApiClientProvider {}

class _$GetDataApiClientProvider extends _i1073.GetDataApiClientProvider {}

class _$OrdersApiDriverProvider extends _i47.OrdersApiDriverProvider {}

class _$LogoutApiClientProvider extends _i894.LogoutApiClientProvider {}

class _$LocaleInitializer extends _i631.LocaleInitializer {}

class _$AppLocalizationsProvider extends _i363.AppLocalizationsProvider {}
