import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:flower_tracking_app/modules/logout/data/models/logout/logout_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'logout_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class LogoutApiClient {
  factory LogoutApiClient(Dio dio) = _LogoutApiClient;

  @GET(ApisEndpoints.logoutEndpoint)
  Future<LogoutResponseDto> logout();
}
