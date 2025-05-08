import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/login/request/login_request_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/login/response/login_response_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/use_cases/login/login_use_case.dart';
import 'package:flower_tracking_app/modules/authentication/ui/login/view_model/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(const LoginState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void doIntent(LoginIntent intent) {
    switch (intent) {
      case Login():
        _login(intent.loginRequest, intent.rememberMe);
    }
  }

  void _login(LoginRequestEntity loginRequest, bool rememberMe) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!formKey.currentState!.validate() ||
        state.loginStatus == Status.loading) {
      return;
    }
    emit(const LoginState(loginStatus: Status.loading));
    var useCaseResult = await _loginUseCase.call(
      loginRequest: loginRequest,
      rememberMe: rememberMe,
    );
    switch (useCaseResult) {
      case Success<LoginResponseEntity>():
        emit(const LoginState(loginStatus: Status.success));
      case Error<LoginResponseEntity>():
        emit(LoginState(loginStatus: Status.error, error: useCaseResult.error));
    }
  }
}

sealed class LoginIntent {}

class Login extends LoginIntent {
  LoginRequestEntity loginRequest;
  bool rememberMe;

  Login({required this.loginRequest, required this.rememberMe});
}
