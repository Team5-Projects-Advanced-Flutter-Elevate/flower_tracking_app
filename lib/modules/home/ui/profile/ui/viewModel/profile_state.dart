part of 'profile_cubit.dart';

enum LoadProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final LoadProfileStatus loadProfileStatus;
  final LoggedDriverDataResponseEntity ?loggedDriverDataResponseEntity;
  final Object? loadProfileError;

  const ProfileState({
    this.loadProfileStatus = LoadProfileStatus.initial,
    this.loadProfileError,
    this.loggedDriverDataResponseEntity
  });

  ProfileState copyWith({
    LoadProfileStatus? loadProfileStatus,
    Object? loadProfileError,
    LoggedDriverDataResponseEntity? loggedDriverDataResponseEntity
  }) {
    return ProfileState(
      loadProfileStatus: loadProfileStatus ?? this.loadProfileStatus,
      loadProfileError: loadProfileError ?? this.loadProfileError,
      loggedDriverDataResponseEntity: loggedDriverDataResponseEntity ?? this.loggedDriverDataResponseEntity
    );
  }

  @override
  List<Object?> get props => [
    loadProfileStatus,
    loadProfileError,
    loggedDriverDataResponseEntity
  ];
}
