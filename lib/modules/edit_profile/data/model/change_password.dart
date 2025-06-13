import '../../domain/entity/change_password.dart';

class ChangePasswordModel {
  ChangePasswordModel({required this.message, required this.token});

  final String? message;
  final String? token;

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(message: json["message"], token: json["token"]);
  }

  Map<String, dynamic> toJson() => {"message": message, "token": token};
  ChangePasswordEntity toEntity() {
    return ChangePasswordEntity(message: message, token: token);
  }

  /// Creates a model from an entity
  factory ChangePasswordModel.fromEntity(ChangePasswordEntity entity) {
    return ChangePasswordModel(message: entity.message, token: entity.token);
  }
}
