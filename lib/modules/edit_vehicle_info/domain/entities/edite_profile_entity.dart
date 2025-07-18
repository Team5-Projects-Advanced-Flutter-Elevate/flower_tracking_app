class EditProfileEntity {
  final String? message;
  final DriverEntity? driver;

  EditProfileEntity({this.message, this.driver});
}

class DriverEntity {
  final String? sId;
  final String? country;
  final String? firstName;
  final String? lastName;
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;
  final String? nID;
  final String? nIDImg;
  final String? email;
  final String? password;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? createdAt;
  final String? passwordChangedAt;
  final String? passwordResetCode;
  final String? passwordResetExpires;
  final bool? resetCodeVerified;
  final String? role;

  DriverEntity({
    this.sId,
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nID,
    this.nIDImg,
    this.email,
    this.password,
    this.gender,
    this.phone,
    this.photo,
    this.createdAt,
    this.passwordChangedAt,
    this.passwordResetCode,
    this.passwordResetExpires,
    this.resetCodeVerified,
    this.role,
  });
}
