import 'package:flower_tracking_app/modules/authentication/domain/repositories_contracts/forget_password/reset_password_repo.dart';

import 'package:mockito/annotations.dart';

@GenerateMocks([ResetPasswordRepo])
void main() {
  // group("useCase Test",() {
  //   late ResetPasswordUseCase useCase;
  //   late ResetPasswordRepo repo;
  //   setUp(() {
  //     repo = MockResetPasswordRepo();
  //     useCase = ResetPasswordUseCase(repo);
  //   },);
  //   test('when call method call it should '
  //       'call resetCode from repo', () async {
  //     var result = Success<ForgetPasswordResponse?>(data: ForgetPasswordResponse());
  //
  //     provideDummy<ApiResult<ForgetPasswordResponse?>>(result);
  //
  //     when(repo.resetPassword("muhamadbishta@gmail.com", "Mohamed@1234")).thenAnswer((realInvocation) async{
  //       return result;
  //     },);
  //
  //     var actual = await useCase.call("muhamadbishta@gmail.com", "Mohamed@1234");
  //
  //     verify(repo.resetPassword("muhamadbishta@gmail.com", "Mohamed@1234")).called(1);
  //
  //     expect(actual, equals(result));
  //   });
  // },);
}
