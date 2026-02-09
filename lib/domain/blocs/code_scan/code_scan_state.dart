part of 'code_scan_bloc.dart';

@immutable
sealed class CodeScanState {}

final class Registrating extends CodeScanState {
  final IdCodeInfo? idDocInfo;
  final RegisterType? registerType;
  final bool? isInFence;
  final String? errorMessage;
  final LatLng? currentLocation;
  final bool isLoading;

  Registrating({
    this.idDocInfo,
    this.registerType,
    this.isInFence,
    this.errorMessage,
    this.currentLocation,
    this.isLoading = false
  });

  Registrating copyWith({
    IdCodeInfo? idDocInfo,
    RegisterType? registerType,
    bool? isInFence,
    String? errorMessage,
    LatLng? currentLocation,
    bool? isLoading
  }) => Registrating(
    idDocInfo: idDocInfo ?? this.idDocInfo,
    registerType: registerType ?? this.registerType,
    isInFence: isInFence ?? this.isInFence,
    currentLocation: currentLocation ?? this.currentLocation,
    errorMessage: errorMessage,
    isLoading: isLoading ?? this.isLoading
  );
}

final class ScanningInProgress extends CodeScanState {}