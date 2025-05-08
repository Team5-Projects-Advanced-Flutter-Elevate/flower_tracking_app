import 'package:flower_tracking_app/modules/authentication/data/api/api_client/auth_api_client.dart';
import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/forget_password/reset_password_remote_data_source.dart';
import 'package:flower_tracking_app/modules/authentication/data/data_sources_imp/forget_password/reset_password_remote_data_source_impl.dart';
import 'package:flower_tracking_app/modules/authentication/data/models/forget_password/forget_password_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_remote_data_source_imp_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  group("ForgetPassword Repo", () {
    late AuthApiClient apiClient;
    late ResetPasswordRemoteDataSource dataSource;
    setUp(() {
      apiClient = MockAuthApiClient();
      dataSource = ResetPasswordRemoteDataSourceImpl(apiClient);
    },);
    test('TODO: Implement tests for forget_password_repo_imp.dart', () async {

      var result = ForgetPasswordResponse();

      when(apiClient.resetPassword(
          {
            "email":"muhamadbishta@gmail.com",
            "newPassword":"Mohamed@1234"
          })).thenAnswer((realInvocation) async =>  result,);

      var actual = await apiClient.resetPassword({"email":"muhamadbishta@gmail.com", "newPassword":"Mohamed@1234"});

      verify(apiClient.resetPassword({"email":"muhamadbishta@gmail.com", "newPassword":"Mohamed@1234"})).called(1);
      expect(actual, equals(result));
    });
  },);

}