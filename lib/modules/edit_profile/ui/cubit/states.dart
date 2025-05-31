import 'package:equatable/equatable.dart';

enum EditProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final EditProfileStatus uploadImageStatus;
  final EditProfileStatus getProfileDataStatus;
  final EditProfileStatus updateProfileStatus;
  final EditProfileStatus changePasswordStatus;
  final String? profilePhotoLink;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String? error;

  const ProfileState({
    this.uploadImageStatus = EditProfileStatus.initial,
    this.getProfileDataStatus = EditProfileStatus.initial,
    this.updateProfileStatus = EditProfileStatus.initial,
    this.changePasswordStatus = EditProfileStatus.initial,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phoneNumber = '',
    this.password = '',
    this.profilePhotoLink,
    this.error,
  });

  ProfileState copyWith({
    EditProfileStatus? uploadImageStatus,
    EditProfileStatus? getProfileDataStatus,
    EditProfileStatus? changePasswordStatus,
    EditProfileStatus? updateProfileStatus,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
    String? profilePhotoLink,
    String? error,
  }) {
    return ProfileState(
      uploadImageStatus: uploadImageStatus ?? this.uploadImageStatus,
      getProfileDataStatus: getProfileDataStatus ?? this.getProfileDataStatus,
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      profilePhotoLink: profilePhotoLink ?? this.profilePhotoLink,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    updateProfileStatus,
    uploadImageStatus,
    getProfileDataStatus,
    changePasswordStatus,
    firstName,
    lastName,
    email,
    phoneNumber,
    password,
    profilePhotoLink,
    error,
  ];

  bool isSameAs(ProfileState other) {
    return firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        phoneNumber == other.phoneNumber &&
        password == other.password &&
        profilePhotoLink == other.profilePhotoLink;
  }
}
