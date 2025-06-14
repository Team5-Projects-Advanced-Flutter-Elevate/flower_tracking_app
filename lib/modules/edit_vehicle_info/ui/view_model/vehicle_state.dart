part of 'vehicle_cubit.dart';

enum PickImageStatus { initial, loading, success, error, unPicked }

enum EditeVehicleStatus { initial, loading, success, error }

enum LoadVehicleStatus { initial, loading, success, error }

enum LoadVehicleDataStatus { initial, loading, success, error }

enum ButtonStatus { enable, disable }

class VehicleState extends Equatable {
  final PickImageStatus pickImageStatus;
  final EditeVehicleStatus editVehicleStatus;
  final LoadVehicleStatus loadVehicleStatus;
  final LoadVehicleDataStatus loadVehicleDataStatus;
  final VehicleEntity? selectedVehicle;
  final File? pickedLicenseImage;
  final bool? isLicenseImagePicked;
  final List<VehicleEntity>? vehicles;
  final ButtonStatus buttonStatus;
  final Object? pickImageError;
  final Object? editVehicleError;
  final Object? loadVehicleError;

  const VehicleState({
    this.pickImageStatus = PickImageStatus.initial,
    this.editVehicleStatus = EditeVehicleStatus.initial,
    this.loadVehicleStatus = LoadVehicleStatus.initial,
    this.selectedVehicle,
    this.pickedLicenseImage,
    this.isLicenseImagePicked = false,
    this.vehicles,
    this.pickImageError,
    this.editVehicleError,
    this.loadVehicleDataStatus = LoadVehicleDataStatus.initial,
    this.loadVehicleError,
    this.buttonStatus = ButtonStatus.disable,
  });

  VehicleState copyWith({
    List<CountryModel>? countries,
    PickImageStatus? pickImageStatus,
    EditeVehicleStatus? editeVehicleStatus,
    VehicleEntity? selectedVehicle,
    File? pickedLicenseImage,
    bool? isLicenseImagePicked,
    LoadVehicleStatus? loadVehicleStatus,
    List<VehicleEntity>? vehicles,
    Object? pickImageError,
    Object? loadVehicleError,
    Object? editVehicleError,
    LoadVehicleDataStatus? loadVehicleDataStatus,
    ButtonStatus? buttonStatus,
  }) => VehicleState(
    buttonStatus: buttonStatus ?? this.buttonStatus,
    pickImageStatus: pickImageStatus ?? this.pickImageStatus,
    editVehicleStatus: editeVehicleStatus ?? editVehicleStatus,
    selectedVehicle: selectedVehicle ?? this.selectedVehicle,
    pickedLicenseImage: pickedLicenseImage ?? this.pickedLicenseImage,
    isLicenseImagePicked: isLicenseImagePicked ?? this.isLicenseImagePicked,
    loadVehicleStatus: loadVehicleStatus ?? this.loadVehicleStatus,
    vehicles: vehicles ?? this.vehicles,
    pickImageError: pickImageError ?? this.pickImageError,
    editVehicleError: editVehicleError ?? this.editVehicleError,
    loadVehicleError: loadVehicleError ?? this.loadVehicleError,
    loadVehicleDataStatus: loadVehicleDataStatus ?? this.loadVehicleDataStatus,
  );

  @override
  List<Object?> get props => [
    pickImageStatus,
    editVehicleStatus,
    selectedVehicle,
    pickedLicenseImage?.path,
    isLicenseImagePicked,
    loadVehicleStatus,
    vehicles,
    pickImageError,
    editVehicleError,
    loadVehicleError,
    loadVehicleStatus,
  ];
}
