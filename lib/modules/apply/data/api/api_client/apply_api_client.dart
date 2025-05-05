import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../../core/apis/apis_endpoints/apis_endpoints.dart';
import '../../models/apply_response.dart';

part 'apply_api_client.g.dart';

@RestApi()
abstract class ApplyApiClient {
  factory ApplyApiClient(Dio dio) = _ApplyApiClient;

  @POST(ApisEndpoints.applyDriver)
  Future<ApplyResponse> applyDriver(@Body() FormData formData);
}
