import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:flower_tracking_app/modules/edit_profile/data/model/change_password.dart';
import 'package:flower_tracking_app/modules/edit_profile/data/model/edit_info.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/get_data.dart';

part 'get_data_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class GetDataApiClient {
  factory GetDataApiClient(Dio dio) = _GetDataApiClient;

  @GET(ApisEndpoints.loggedDriverDataEndPoint)
  Future<GetData> getLoggedDriverData();

  @PUT(ApisEndpoints.editInfo)
  Future<EditMyInfo> editInfo(@Body() Map<String, dynamic> body);

  @PATCH(ApisEndpoints.changePassword)
  Future<ChangePasswordModel> changePassword(@Body() Map<String, dynamic> body);
}
