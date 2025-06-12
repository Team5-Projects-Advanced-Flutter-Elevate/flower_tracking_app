part of 'profile_cubit.dart';

enum LoadProfileStatus { initial, loading, success, error }

enum LogoutStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final LoadProfileStatus loadProfileStatus;
  final LogoutStatus logoutStatus;
  final LoggedDriverDataResponseEntity? loggedDriverDataResponseEntity;
  final Object? loadProfileError;
  final Object? logoutError;

  const ProfileState({
    this.logoutError,
    this.loadProfileStatus = LoadProfileStatus.initial,
    this.logoutStatus = LogoutStatus.initial,
    this.loadProfileError,
    this.loggedDriverDataResponseEntity,
  });

  ProfileState copyWith({
    Object? logoutError,
    LoadProfileStatus? loadProfileStatus,
    LogoutStatus? logoutStatus,
    Object? loadProfileError,
    LoggedDriverDataResponseEntity? loggedDriverDataResponseEntity,
  }) {
    return ProfileState(
      loadProfileStatus: loadProfileStatus ?? this.loadProfileStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      loadProfileError: loadProfileError ?? this.loadProfileError,
      loggedDriverDataResponseEntity:
          loggedDriverDataResponseEntity ?? this.loggedDriverDataResponseEntity,
      logoutError: logoutError ?? this.logoutError,
    );
  }

  @override
  List<Object?> get props => [
    loadProfileStatus,
    logoutStatus,
    loadProfileError,
    loggedDriverDataResponseEntity,
    logoutError,
  ];
}
