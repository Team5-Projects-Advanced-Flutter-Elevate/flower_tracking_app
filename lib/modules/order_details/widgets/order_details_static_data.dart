import 'package:flutter/cupertino.dart';

import '../../../shared_layers/localization/generated/app_localizations.dart';

class OrderDetailsStaticData {
  final String statusKey;
  final String buttonTitleKey;

  String getStatus(BuildContext context) => _getLocalizedStatus(context);

  String getButtonTitle(BuildContext context) =>
      _getLocalizedButtonTitle(context);

  static List<OrderDetailsStaticData> getDataList() => [
    const OrderDetailsStaticData(
      'orderStatusAccepted',
      'buttonArrivedAtPickup',
    ),
    const OrderDetailsStaticData('orderStatusPicked', 'buttonStartDelivery'),
    const OrderDetailsStaticData(
      'orderStatusOutForDelivery',
      'buttonArrivedDestination',
    ),
    const OrderDetailsStaticData('orderStatusArrived', 'buttonOrderDelivered'),
    const OrderDetailsStaticData(
      'orderStatusDelivered',
      'buttonOrderDelivered',
    ),
  ];

  const OrderDetailsStaticData(this.statusKey, this.buttonTitleKey);

  String _getLocalizedStatus(BuildContext context) {
    switch (statusKey) {
      case 'orderStatusAccepted':
        return AppLocalizations.of(context)!.orderStatusAccepted;
      case 'orderStatusPicked':
        return AppLocalizations.of(context)!.orderStatusPicked;
      case 'orderStatusOutForDelivery':
        return AppLocalizations.of(context)!.orderStatusOutForDelivery;
      case 'orderStatusArrived':
        return AppLocalizations.of(context)!.orderStatusArrived;
      case 'orderStatusDelivered':
        return AppLocalizations.of(context)!.orderStatusDelivered;
      default:
        return statusKey;
    }
  }

  String _getLocalizedButtonTitle(BuildContext context) {
    switch (buttonTitleKey) {
      case 'buttonArrivedAtPickup':
        return AppLocalizations.of(context)!.buttonArrivedAtPickup;
      case 'buttonStartDelivery':
        return AppLocalizations.of(context)!.buttonStartDelivery;
      case 'buttonArrivedDestination':
        return AppLocalizations.of(context)!.buttonArrivedDestination;
      case 'buttonOrderDelivered':
        return AppLocalizations.of(context)!.buttonOrderDelivered;
      default:
        return buttonTitleKey;
    }
  }
}
