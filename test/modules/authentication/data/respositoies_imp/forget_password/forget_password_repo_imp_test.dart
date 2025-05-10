import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/forget_password/forget_password_remote_data_source.dart';

import 'package:mockito/annotations.dart';

@GenerateMocks([ForgetPasswordRemoteDataSource])
void main() {
  // group("ForgetPassword Repo", () {
  //   late ForgetPasswordRepoImpl forgetPasswordRepo;
  //   late ForgetPasswordRemoteDataSource dataSource;
  //   setUp(() {
  //     dataSource = MockForgetPasswordRemoteDataSource();
  //     forgetPasswordRepo = ForgetPasswordRepoImpl(dataSource);
  //   },);
  //   test('TODO: Implement tests for forget_password_repo_imp.dart', () async {
  //     var result = Success<ForgetPasswordResponse?>(data: ForgetPasswordResponse());
  //
  //     provideDummy<ApiResult<ForgetPasswordResponse?>>(result);
  //
  //     when(dataSource.forgetPassword("muhamadbishta@gmail.com")).thenAnswer((realInvocation) async => result,);
  //
  //     var actual = await dataSource.forgetPassword("muhamadbishta@gmail.com");
  //
  //     verify(dataSource.forgetPassword("muhamadbishta@gmail.com")).called(1);
  //     expect(actual, equals(result));
  //   });
  // },);
}
