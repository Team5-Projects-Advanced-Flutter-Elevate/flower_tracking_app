import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:flower_tracking_app/modules/authentication/data/models/logged_driver_data/logged_driver_data_response_dto.dart';
import 'package:flower_tracking_app/modules/authentication/data/models/login/request/login_request_dto.dart';
import 'package:flower_tracking_app/modules/authentication/data/models/login/response/login_response_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract interface class AuthApiClient {
  factory AuthApiClient(Dio dio) =
      _AuthApiClient;

  @POST(ApisEndpoints.loginEndPoint)
  Future<LoginResponseDto> login(@Body() LoginRequestDto loginRequestDto);

  @GET(ApisEndpoints.loggedDriverDataEndPoint)
  Future<LoggedDriverDataResponseDto> getLoggedDriverData();
}
