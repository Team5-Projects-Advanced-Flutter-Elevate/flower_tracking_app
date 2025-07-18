import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/apis/api_result/api_result.dart';
import '../../../data/models/forget_password/forget_password_response.dart';
import '../../../domain/use_cases/forget_password/reset_code_use_case.dart';
import 'forget_password_state.dart';

@injectable
class ResetCodeViewModel extends Cubit<OtpState> {
  ResetCodeUseCase resetCodeUseCase;

  @factoryMethod
  ResetCodeViewModel(this.resetCodeUseCase) : super(OtpInitialState());

  void onIntent(OtpIntent intent) {
    switch (intent) {
      case ResetCodeIntent():
        _resetCodeHandling(intent.code);
        break;
      case StartTimer():
        _startTimer(numberOfSeconds: intent.numberOfSeconds);
        break;
    }
  }

  final ValueNotifier<int> timeRemaining = ValueNotifier(1);
  Timer? _timer;
  _resetCodeHandling(String code) async {
    emit(OtpLoadingState());
    var result = await resetCodeUseCase.call(code);
    switch (result) {
      case Success<ForgetPasswordResponse?>():
        emit(OtpSuccessState());
      case Error<ForgetPasswordResponse?>():
        emit(OtpErrorState(result.error));
    }
  }
  void _startTimer({required int numberOfSeconds}) {
    if (_timer?.isActive == true) {
      return;
    }
    timeRemaining.value = numberOfSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value -= 1;
      } else {
        _timer?.cancel();
      }
    });
  }

}

sealed class OtpIntent {}

class ResetCodeIntent extends OtpIntent {
  final String code;

  ResetCodeIntent(this.code);
}

class StartTimer extends OtpIntent{
  int numberOfSeconds;
  StartTimer({required this.numberOfSeconds});
}
