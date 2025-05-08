import 'package:dio/dio.dart';
import 'package:flower_tracking_app/modules/authentication/data/api/api_client/auth_api_client.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthApiClientProvider {

  @lazySingleton
  AuthApiClient provideApiClient(Dio dio) {
    return AuthApiClient(dio);
  }
}