sealed class PasswordState {}

class PasswordInitialState extends PasswordState {}

class PasswordLoadingState extends PasswordState {}

class PasswordErrorState extends PasswordState {
  final Object error;
  PasswordErrorState(this.error);
}

class PasswordSuccessState extends PasswordState {}

class EmailLoadingState extends PasswordState {}

class EmailErrorState extends PasswordState {
  final Object error;
  EmailErrorState(this.error);
}

class EmailSuccessState extends PasswordState {}

class OtpLoadingState extends PasswordState {}

class OtpErrorState extends PasswordState {
  final Object error;
  OtpErrorState(this.error);
}

class OtpSuccessState extends PasswordState {}
