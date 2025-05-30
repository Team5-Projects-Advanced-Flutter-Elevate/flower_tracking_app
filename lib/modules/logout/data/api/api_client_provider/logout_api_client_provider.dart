
import 'package:dio/dio.dart';
import 'package:flower_tracking_app/modules/logout/data/api/api_client/logout_api_client.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LogoutApiClientProvider {

  @lazySingleton
  LogoutApiClient provideClient(Dio dio){
    return LogoutApiClient(dio);
  }
}