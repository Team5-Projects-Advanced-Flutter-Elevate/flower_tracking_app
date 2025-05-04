import 'dart:ui';
import 'package:flower_tracking_app/shared_layers/localization/generated/app_localizations.dart';
import 'package:injectable/injectable.dart';
import '../../../shared_layers/localization/constants/l10n_constants.dart';

@module
abstract class AppLocalizationsProvider {
  @preResolve
  Future<AppLocalizations> provideAppLocalizations(
    @Named(L10nConstants.initCurrentLocal) String languageCode,
  ) {
    return AppLocalizations.delegate.load(Locale(languageCode));
  }
}
