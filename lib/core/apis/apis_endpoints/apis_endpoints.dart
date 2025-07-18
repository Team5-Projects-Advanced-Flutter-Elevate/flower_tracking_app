class ApisEndpoints {
  static const String baseUrl = 'https://flower.elevateegy.com/';
  static const String loginEndPoint = 'api/v1/drivers/signin';
  static const String forgetPasswordEndPoint = 'api/v1/drivers/forgotPassword';
  static const String resetPasswordEndPoint = 'api/v1/drivers/resetPassword';
  static const String resetCodeEndPoint = 'api/v1/drivers/verifyResetCode';
  static const String loggedDriverDataEndPoint = 'api/v1/drivers/profile-data';
  static const String applyDriver = 'api/v1/drivers/apply';
  static const String getVehicles = 'api/v1/vehicles';
  static const String getPendingOrders = 'api/v1/orders/pending-orders';
  static const String updateOrderState = 'api/v1/orders/state';
  static const String editProfile = 'api/v1/drivers/editProfile';
  static const String driverOrders = 'api/v1/orders/driver-orders';
  static const String editInfo = 'api/v1/drivers/editProfile';
  static const String uploadProfileImage = 'api/v1/drivers/upload-photo';
  static const String changePassword = 'api/v1/drivers/change-password';
  static const String logoutEndpoint = "api/v1/drivers/logout";

  // Open Route Service
  static const String openRouteServiceBaseUrl =
      "https://api.openrouteservice.org/";
  static const String directionsEndPoint = "v2/directions/driving-car/geojson";
}
