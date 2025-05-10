import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/forget_password/reset_code_remote_data_source.dart';

import 'package:mockito/annotations.dart';

@GenerateMocks([ResetCodeRemoteDataSource])
void main() {
  // group("ForgetPassword Repo", () {
  //   late ResetCodeRepoImpl resetCodeRepo;
  //   late ResetCodeRemoteDataSource dataSource;
  //   setUp(() {
  //     dataSource = MockResetCodeRemoteDataSource();
  //     resetCodeRepo = ResetCodeRepoImpl(dataSource);
  //   },);
  //   test('TODO: Implement tests for forget_password_repo_imp.dart', () async {
  //     var result = Success<ForgetPasswordResponse?>(data: ForgetPasswordResponse());
  //
  //     provideDummy<ApiResult<ForgetPasswordResponse?>>(result);
  //
  //     when(dataSource.resetCode("123453")).thenAnswer((realInvocation) async => result,);
  //
  //     var actual = await dataSource.resetCode("123453");
  //
  //     verify(dataSource.resetCode("123453")).called(1);
  //     expect(actual, equals(result));
  //   });
  // },);
}
