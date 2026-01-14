part of 'code_scan_bloc.dart';

@immutable
sealed class CodeScanEvent {}


final class InsertScanInfo extends CodeScanEvent {
  final IdCodeInfo? idCodeInfo;

  InsertScanInfo(this.idCodeInfo);
}

final class SetRegisterType extends CodeScanEvent {
  final RegisterType registerType;

  SetRegisterType(this.registerType);
}

final class RetryScanEnd extends CodeScanEvent {}

