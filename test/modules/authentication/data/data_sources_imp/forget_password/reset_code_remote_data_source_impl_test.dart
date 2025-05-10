import 'package:flower_tracking_app/modules/authentication/data/api/api_client/auth_api_client.dart';

import 'package:mockito/annotations.dart';


@GenerateMocks([AuthApiClient])
void main() {
  // group("ForgetPassword Repo", () {
  //   late AuthApiClient apiClient;
  //   late ResetCodeRemoteDataSource dataSource;
  //   setUp(() {
  //     apiClient = MockAuthApiClient();
  //     dataSource = ResetCodeRemoteDataSourceImpl(apiClient);
  //   },);
  //   test('TODO: Implement tests for forget_password_repo_imp.dart', () async {
  //
  //     var result = ForgetPasswordResponse();
  //
  //     when(apiClient.resetCode({"resetCode": "123456"})).thenAnswer((realInvocation) async =>  result,);
  //
  //     var actual = await apiClient.resetCode({"resetCode": "123456"});
  //
  //     verify(apiClient.resetCode({"resetCode": "123456"})).called(1);
  //     expect(actual, equals(result));
  //   });
  // },);

}