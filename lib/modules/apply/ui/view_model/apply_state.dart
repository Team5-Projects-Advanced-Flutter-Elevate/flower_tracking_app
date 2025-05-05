part of 'apply_cubit.dart';

enum LoadCountryStatus { initial, loading, success, error }

enum PickImageStatus { initial, loading, success, error }

enum ApplyDriverStatus { initial, loading, success, error }

class ApplyState extends Equatable {
  final LoadCountryStatus loadCountryStatus;
  final PickImageStatus pickImageStatus;
  final ApplyDriverStatus applyDriverStatus;
  final String? selectedCountry;
  final String? selectedVehicle;
  final File? pickedLicenseImage;
  final File? pickedIdImage;
  final bool? isIdImagePicked;
  final bool? isLicenseImagePicked;
  final String? selectedGender;
  final List<CountryModel> countries;
  final Object? error;

  const ApplyState({
    this.loadCountryStatus = LoadCountryStatus.initial,
    this.pickImageStatus = PickImageStatus.initial,
    this.applyDriverStatus = ApplyDriverStatus.initial,
    this.countries = const [],
    this.error,
    this.selectedVehicle,
    this.selectedCountry,
    this.pickedLicenseImage,
    this.pickedIdImage,
    this.isIdImagePicked = false,
    this.isLicenseImagePicked = false,
    this.selectedGender ,
  });

  ApplyState copyWith({
    LoadCountryStatus? loadCountryStatus,
    List<CountryModel>? countries,
    Object? error,
    PickImageStatus? pickImageStatus,
    ApplyDriverStatus? applyDriverStatus,
    String? selectedCountry,
    String? selectedVehicle,
    File? pickedLicenseImage,
    File? pickedIdImage,
    bool? isIdImagePicked,
    bool? isLicenseImagePicked,
    String? selectedGender,
  }) => ApplyState(
    loadCountryStatus: loadCountryStatus ?? this.loadCountryStatus,
    countries: countries ?? this.countries,
    error: error ?? this.error,
    pickImageStatus: pickImageStatus ?? this.pickImageStatus,
    applyDriverStatus: applyDriverStatus ?? this.applyDriverStatus,
    selectedCountry: selectedCountry ?? this.selectedCountry,
    selectedVehicle: selectedVehicle ?? this.selectedVehicle,
    pickedLicenseImage: pickedLicenseImage ?? this.pickedLicenseImage,
    pickedIdImage: pickedIdImage ?? this.pickedIdImage,
    isIdImagePicked: isIdImagePicked ?? this.isIdImagePicked,
    isLicenseImagePicked: isLicenseImagePicked ?? this.isLicenseImagePicked,
    selectedGender: selectedGender ?? this.selectedGender,
  );

  @override
  List<Object?> get props => [
    loadCountryStatus,
    countries,
    error,
    pickImageStatus,
    applyDriverStatus,
    selectedCountry,
    selectedVehicle,
    pickedLicenseImage,
    pickedIdImage,
    isIdImagePicked,
    isLicenseImagePicked,
    selectedGender,
  ];

}
