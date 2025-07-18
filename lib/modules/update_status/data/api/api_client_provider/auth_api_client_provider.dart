import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api_client/status_api_client.dart';

@module
abstract class StateApiClientProvider {
  @lazySingleton
  StateApiClient provideApiClient(Dio dio) {
    return StateApiClient(dio);
  }
}
