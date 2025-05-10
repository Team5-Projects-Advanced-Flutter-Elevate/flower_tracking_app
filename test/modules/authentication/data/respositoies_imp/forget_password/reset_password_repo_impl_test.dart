import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/forget_password/reset_password_remote_data_source.dart';

import 'package:mockito/annotations.dart';

@GenerateMocks([ResetPasswordRemoteDataSource])
void main() {
  // group("ForgetPassword Repo", () {
  //   late ResetPasswordRepoImpl resetPasswordRepo;
  //   late ResetPasswordRemoteDataSource dataSource;
  //   setUp(() {
  //     dataSource = MockResetPasswordRemoteDataSource();
  //     resetPasswordRepo = ResetPasswordRepoImpl(dataSource);
  //   },);
  //   test('TODO: Implement tests for forget_password_repo_imp.dart', () async {
  //     var result = Success<ForgetPasswordResponse?>(data: ForgetPasswordResponse());
  //
  //     provideDummy<ApiResult<ForgetPasswordResponse?>>(result);
  //
  //     when(dataSource.resetPassword("muhamadbishta@gmail.com", "Mohamed@1234")).thenAnswer((realInvocation) async => result,);
  //
  //     var actual = await dataSource.resetPassword("muhamadbishta@gmail.com", "Mohamed@1234");
  //
  //     verify(dataSource.resetPassword("muhamadbishta@gmail.com", "Mohamed@1234")).called(1);
  //     expect(actual, equals(result));
  //   });
  // },);
}
