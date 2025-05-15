import 'package:flower_tracking_app/modules/whatsapp_call/domain/usecase/call_usecase.dart';
import 'package:flower_tracking_app/modules/whatsapp_call/domain/usecase/whatsapp_usecase.dart';
import 'package:flower_tracking_app/modules/whatsapp_call/ui/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/apis/api_result/api_result.dart';

@injectable
class LauncherViewModel extends Cubit<LauncherState> {
  WhatsAppUseCase whatsAppUseCase;
  CallUseCase callUseCase;

  @factoryMethod
  LauncherViewModel(this.whatsAppUseCase, this.callUseCase)
    : super(LauncherInitial());

  void onIntent(LauncherIntent intent) {
    switch (intent) {
      case WhatsAppIntent():
        _whatsAppHandling(intent.phoneNumber);
        break;
      case CallIntent():
        _callHandling(intent.phoneNumber);
        break;
    }
  }

  _whatsAppHandling(String phoneNumber) async {
    emit(LauncherLoading());
    var result = await whatsAppUseCase.whatsApp(phoneNumber);
    switch (result) {
      case Success<void>():
        emit(LauncherSuccess());

      case Error<void>():
        emit(LauncherError(result.error.toString()));
    }
  }

  _callHandling(String phoneNumber) async {
    emit(LauncherLoading());
    var result = await callUseCase.call(phoneNumber);
    switch (result) {
      case Success<void>():
        emit(LauncherSuccess());

      case Error<void>():
        emit(LauncherError(result.error.toString()));
    }
  }
}

sealed class LauncherIntent {}

class WhatsAppIntent extends LauncherIntent {
  final String phoneNumber;

  WhatsAppIntent(this.phoneNumber);
}

class CallIntent extends LauncherIntent {
  final String phoneNumber;

  CallIntent(this.phoneNumber);
}
