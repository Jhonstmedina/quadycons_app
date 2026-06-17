part of 'code_scan_bloc.dart';

@immutable
sealed class CodeScanEvent {}


final class InsertScanInfo extends CodeScanEvent {
  final IdCodeInfo? idCodeInfo;
  final Project project;
  final List<Project> allProjects;
  
  InsertScanInfo(
    this.idCodeInfo,
    this.project,
    this.allProjects
  );
}

final class SetRegisterType extends CodeScanEvent {
  final RegisterType registerType;
  final Project project;
  SetRegisterType(
    this.registerType,
    this.project
  );
}

final class RetryScanEnd extends CodeScanEvent {
  final Project project;
  RetryScanEnd({required this.project});
}

final class ResetBloc extends CodeScanEvent {}

