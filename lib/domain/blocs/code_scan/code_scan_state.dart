part of 'code_scan_bloc.dart';

@immutable
sealed class CodeScanState {}

final class Registrating extends CodeScanState {
  final IdCodeInfo? idDocInfo;
  final RegisterType? registerType;
  final bool? isInFence;
  final String? errorMessage;

  Registrating({
    this.idDocInfo,
    this.registerType,
    this.isInFence,
    this.errorMessage
  });

  Registrating copyWith({
    IdCodeInfo? idDocInfo,
    RegisterType? registerType,
    bool? isInFence,
    String? errorMessage
  }) => Registrating(
    idDocInfo: idDocInfo ?? this.idDocInfo,
    registerType: registerType ?? this.registerType,
    isInFence: isInFence ?? this.isInFence,
    errorMessage: errorMessage
  );
}

final class ScanningInProgress extends CodeScanState {}