part of 'permissions_bloc.dart';

@immutable
sealed class PermissionsEvent {}

final class RequestPermissions extends PermissionsEvent {}

final class _UpdatePermissionsStatus extends PermissionsEvent {}