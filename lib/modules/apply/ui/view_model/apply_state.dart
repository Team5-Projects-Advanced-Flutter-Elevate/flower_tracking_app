part of 'apply_cubit.dart';

enum LoadCountryStatus { initial, loading, success, error }

class ApplyState extends Equatable {
  final LoadCountryStatus loadCountryStatus;
  final List<CountryModel> countries;
  final Object? error;
  final int? egyptIndex;

  const ApplyState({
    this.loadCountryStatus = LoadCountryStatus.initial,
    this.countries = const [],
    this.error,
    this.egyptIndex,
  });

  ApplyState copyWith({
    LoadCountryStatus? loadCountryStatus,
    List<CountryModel>? countries,
    Object? error,
    int? egyptIndex,
  }) => ApplyState(
    loadCountryStatus: loadCountryStatus ?? this.loadCountryStatus,
    countries: countries ?? this.countries,
    error: error ?? this.error,
    egyptIndex: egyptIndex ?? this.egyptIndex,
  );

  @override
  List<Object?> get props => [loadCountryStatus, countries, error, egyptIndex];
}
