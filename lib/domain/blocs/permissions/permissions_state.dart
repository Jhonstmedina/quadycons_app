part of 'permissions_bloc.dart';

@immutable
sealed class PermissionsState {}

final class PermissionsPending extends PermissionsState {
  final bool isLoading;
  final bool cameraIsGranted;
  final bool locationIsGranted;
  final String? errorMessage;
  PermissionsPending({
    this.isLoading = true,
    this.cameraIsGranted = false,
    this.locationIsGranted = false,
    this.errorMessage
  });

  PermissionsPending copyWith({
    bool? isLoading,
    bool? cameraIsGranted,
    bool? locationIsGranted,
    String? errorMessage
  }) => PermissionsPending(
    isLoading: isLoading ?? this.isLoading,
    cameraIsGranted: cameraIsGranted ?? this.cameraIsGranted,
    locationIsGranted: locationIsGranted ?? this.locationIsGranted,
    errorMessage: errorMessage
  );
}

