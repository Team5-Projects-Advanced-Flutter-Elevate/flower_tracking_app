import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:flower_tracking_app/core/utilities/bloc_observer/location_permission_denied.dart';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:injectable/injectable.dart';
import 'api_error_model.dart';
import 'api_error_model_of_open_route_service.dart';


@lazySingleton
class ApiErrorHandler {
  AppLocalizations _appLocalizations;

  set appLocalizations(AppLocalizations appLocalization) {
    _appLocalizations = appLocalization;
  }

  ApiErrorHandler(this._appLocalizations);

  String handle(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return _appLocalizations.connectionTimeout;
        case DioExceptionType.sendTimeout:
          return _appLocalizations.sendTimeout;
        case DioExceptionType.receiveTimeout:
          return _appLocalizations.receiveTimeout;
        case DioExceptionType.badResponse:
          if (error.response?.realUri != null &&
              error.response!.realUri.toString().contains(
                ApisEndpoints.openRouteServiceBaseUrl,
              )) {
            return ApiErrorModelOfOpenRouteService
                .fromJson(error.response?.data)
                .error
                ?.message ?? _appLocalizations.somethingWentWrong;
          }
          return ApiErrorModel
              .fromJson(error.response?.data)
              .error ??
              _appLocalizations.somethingWentWrong;
        case DioExceptionType.cancel:
          return _appLocalizations.cancel;
        case DioExceptionType.connectionError:
          return _appLocalizations.connectionError;
        case DioExceptionType.unknown:
          return _appLocalizations.unknown;
        case DioExceptionType.badCertificate:
          return _appLocalizations.badCertificate;
      }
    } else if (error is LocationPermissionDenied) {
      return error.toString();
    } else {
      return error.toString();
    }
  }
}
