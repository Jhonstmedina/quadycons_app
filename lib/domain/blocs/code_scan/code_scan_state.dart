part of 'code_scan_bloc.dart';

@immutable
sealed class CodeScanState {}

final class Registrating extends CodeScanState {
  final IdCodeInfo? idDocInfo;
  final RegisterType? registerType;
  final bool? isInFence;
  final String? errorMessage;
  final LatLng? currentLocation;

  Registrating({
    this.idDocInfo,
    this.registerType,
    this.isInFence,
    this.errorMessage,
    this.currentLocation
  });

  Registrating copyWith({
    IdCodeInfo? idDocInfo,
    RegisterType? registerType,
    bool? isInFence,
    String? errorMessage,
    LatLng? currentLocation
  }) => Registrating(
    idDocInfo: idDocInfo ?? this.idDocInfo,
    registerType: registerType ?? this.registerType,
    isInFence: isInFence ?? this.isInFence,
    currentLocation: currentLocation ?? this.currentLocation,
    errorMessage: errorMessage
  );
}

final class ScanningInProgress extends CodeScanState {}