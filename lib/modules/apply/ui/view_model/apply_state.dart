part of 'apply_cubit.dart';

enum LoadCountryStatus { initial, loading, success, error }

enum PickImageStatus { initial, loading, success, error, unPicked }

enum ApplyDriverStatus { initial, loading, success, error }

enum LoadVehicleStatus { initial, loading, success, error }

enum LoadApplyDataStatus { initial, loading, success, error }

class ApplyState extends Equatable {
  final LoadCountryStatus loadCountryStatus;
  final PickImageStatus pickImageStatus;
  final ApplyDriverStatus applyDriverStatus;
  final LoadVehicleStatus loadVehicleStatus;
  final LoadApplyDataStatus loadApplyDataStatus;
  final String? selectedCountry;
  final String? selectedVehicle;
  final File? pickedLicenseImage;
  final File? pickedIdImage;
  final bool? isIdImagePicked;
  final bool? isLicenseImagePicked;
  final String? selectedGender;
  final List<CountryModel> countries;
  final List<VehicleEntity>? vehicles;
  final Object? loadCountryError;
  final Object? pickImageError;
  final Object? applyDriverError;
  final Object? loadVehicleError;


  const ApplyState({
    this.loadCountryStatus = LoadCountryStatus.initial,
    this.pickImageStatus = PickImageStatus.initial,
    this.applyDriverStatus = ApplyDriverStatus.initial,
    this.loadVehicleStatus = LoadVehicleStatus.initial,
    this.loadApplyDataStatus = LoadApplyDataStatus.initial,
    this.countries = const [],
    this.selectedVehicle,
    this.selectedCountry,
    this.pickedLicenseImage,
    this.pickedIdImage,
    this.isIdImagePicked = false,
    this.isLicenseImagePicked = false,
    this.selectedGender,
    this.vehicles,
    this.loadCountryError,
    this.pickImageError,
    this.applyDriverError,
    this.loadVehicleError,
  });

  ApplyState copyWith({
    LoadCountryStatus? loadCountryStatus,
    List<CountryModel>? countries,
    PickImageStatus? pickImageStatus,
    ApplyDriverStatus? applyDriverStatus,

    String? selectedCountry,
    String? selectedVehicle,
    File? pickedLicenseImage,
    File? pickedIdImage,
    bool? isIdImagePicked,
    bool? isLicenseImagePicked,
    String? selectedGender,
    LoadVehicleStatus? loadVehicleStatus,
    List<VehicleEntity>? vehicles,
    Object? loadCountryError,
    Object? pickImageError,
    Object? applyDriverError,
    Object? loadVehicleError,
    LoadApplyDataStatus ? loadApplyDataStatus
  }) => ApplyState(
    loadCountryStatus: loadCountryStatus ?? this.loadCountryStatus,
    countries: countries ?? this.countries,
    pickImageStatus: pickImageStatus ?? this.pickImageStatus,
    applyDriverStatus: applyDriverStatus ?? this.applyDriverStatus,
    selectedCountry: selectedCountry ?? this.selectedCountry,
    selectedVehicle: selectedVehicle ?? this.selectedVehicle,
    pickedLicenseImage: pickedLicenseImage ?? this.pickedLicenseImage,
    pickedIdImage: pickedIdImage ?? this.pickedIdImage,
    isIdImagePicked: isIdImagePicked ?? this.isIdImagePicked,
    isLicenseImagePicked: isLicenseImagePicked ?? this.isLicenseImagePicked,
    selectedGender: selectedGender ?? this.selectedGender,
    loadVehicleStatus: loadVehicleStatus ?? this.loadVehicleStatus,
    vehicles: vehicles ?? this.vehicles,
    loadCountryError: loadCountryError ?? this.loadCountryError,
    pickImageError: pickImageError ?? this.pickImageError,
    applyDriverError: applyDriverError ?? this.applyDriverError,
    loadVehicleError: loadVehicleError ?? this.loadVehicleError,
    loadApplyDataStatus: loadApplyDataStatus ?? this.loadApplyDataStatus
  );

  @override
  List<Object?> get props => [
    loadCountryStatus,
    countries,
    pickImageStatus,
    applyDriverStatus,
    selectedCountry,
    selectedVehicle,
    pickedLicenseImage,
    pickedIdImage,
    isIdImagePicked,
    isLicenseImagePicked,
    selectedGender,
    loadVehicleStatus,
    vehicles,
    loadCountryError,
    pickImageError,
    applyDriverError,
    loadVehicleError,
    loadApplyDataStatus,
  ];
}
