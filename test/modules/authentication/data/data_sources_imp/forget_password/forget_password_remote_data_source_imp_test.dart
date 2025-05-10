import 'package:flower_tracking_app/modules/authentication/data/api/api_client/auth_api_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([AuthApiClient])
void main() {
  // group("ForgetPassword Repo", () {
  //   late AuthApiClient apiClient;
  //   late ForgetPasswordRemoteDataSource dataSource;
  //   setUp(() {
  //     apiClient = MockAuthApiClient();
  //     dataSource = ForgetPasswordRemoteDataSourceImpl(apiClient);
  //   },);
  //   test('TODO: Implement tests for forget_password_repo_imp.dart', () async {
  //
  //     var result = ForgetPasswordResponse();
  //
  //     when(apiClient.forgetPassword({"email":"muhamadbishta@gmail.com"})).thenAnswer((realInvocation) async =>  result,);
  //
  //     var actual = await apiClient.forgetPassword({"email":"muhamadbishta@gmail.com"});
  //
  //     verify(apiClient.forgetPassword({"email":"muhamadbishta@gmail.com"})).called(1);
  //     expect(actual, equals(result));
  //   });
  // },);
}
