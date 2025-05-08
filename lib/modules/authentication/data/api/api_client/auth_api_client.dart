import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:flower_tracking_app/modules/authentication/data/models/logged_driver_data/logged_driver_data_response_dto.dart';
import 'package:flower_tracking_app/modules/authentication/data/models/login/request/login_request_dto.dart';
import 'package:flower_tracking_app/modules/authentication/data/models/login/response/login_response_dto.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/forget_password/forget_password_response.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(ApisEndpoints.loginEndPoint)
  Future<LoginResponseDto> login(@Body() LoginRequestDto loginRequestDto);

  @POST(ApisEndpoints.forgetPasswordEndPoint)
  Future<ForgetPasswordResponse?> forgetPassword(
    @Body() Map<String, dynamic> body,
  );
  @GET(ApisEndpoints.loggedDriverDataEndPoint)
  Future<LoggedDriverDataResponseDto> getLoggedDriverData();

  @PUT(ApisEndpoints.resetPasswordEndPoint)
  Future<ForgetPasswordResponse?> resetPassword(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApisEndpoints.resetCodeEndPoint)
  Future<ForgetPasswordResponse?> resetCode(@Body() Map<String, dynamic> body);
}
