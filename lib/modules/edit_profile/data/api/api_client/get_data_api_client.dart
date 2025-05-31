import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/get_data.dart';

part 'get_data_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class GetDataApiClient {
  factory GetDataApiClient(Dio dio) = _GetDataApiClient;

  @GET(ApisEndpoints.loggedDriverDataEndPoint)
  Future<GetData> getLoggedDriverData();

}
