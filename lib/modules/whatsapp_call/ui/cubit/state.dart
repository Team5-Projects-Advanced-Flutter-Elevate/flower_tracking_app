sealed class LauncherState {}

class LauncherInitial extends LauncherState {}

class LauncherLoading extends LauncherState {}

class LauncherSuccess extends LauncherState {}

class LauncherError extends LauncherState {
  final String message;
  LauncherError(this.message);
}
