import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api_client/apply_api_client.dart';

@module
abstract class ApplyApiClientProvider {
  @lazySingleton
  ApplyApiClient providerApiClient(Dio dio) {
    return ApplyApiClient(dio);
  }
}
