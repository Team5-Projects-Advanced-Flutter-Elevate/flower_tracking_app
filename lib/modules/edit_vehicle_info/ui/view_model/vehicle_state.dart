part of 'vehicle_cubit.dart';

enum PickImageStatus { initial, loading, success, error, unPicked }

enum LoadVehicleStatus { initial, loading, success, error }

class VehicleState extends Equatable {
  const VehicleState({
    this.pickedLicenseImage,
    this.isLicenseImagePicked = false,
    this.pickImageStatus = PickImageStatus.initial,
    this.loadVehicleStatus = LoadVehicleStatus.initial,
    this.vehicles,
    this.loadVehicleError,
    this.pickImageError,
  });

  final PickImageStatus pickImageStatus;
  final LoadVehicleStatus loadVehicleStatus;
  final List<VehicleEntity>? vehicles;

  final Object? pickImageError;
  final Object? loadVehicleError;
  final File? pickedLicenseImage;

  final bool? isLicenseImagePicked;

  @override
  // TODO: implement props
  List<Object?> get props => [
    pickImageStatus,
    loadVehicleStatus,
    vehicles,
    pickImageError,
    loadVehicleError,
    pickedLicenseImage,
    isLicenseImagePicked,
  ];

  VehicleState copyWith({
    PickImageStatus? pickImageStatus,
    LoadVehicleStatus? loadVehicleStatus,
    Object? pickImageError,
    List<VehicleEntity>? vehicles,
    Object? loadVehicleError,
    File? pickedLicenseImage,
    bool? isLicenseImagePicked,
  }) {
    return VehicleState(
      pickImageStatus: pickImageStatus ?? this.pickImageStatus,
      loadVehicleStatus: loadVehicleStatus ?? this.loadVehicleStatus,
      pickImageError: pickImageError ?? this.pickImageError,
      vehicles: vehicles ?? this.vehicles,
      loadVehicleError: loadVehicleError ?? this.loadVehicleError,
      pickedLicenseImage: pickedLicenseImage ?? this.pickedLicenseImage,
      isLicenseImagePicked: isLicenseImagePicked ?? this.isLicenseImagePicked,
    );
  }
}
