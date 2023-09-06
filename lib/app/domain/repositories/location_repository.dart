import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Future<Position> getCurrentUserLocation();
  Future<bool> checkisEnabledService();
}

class LocationDisabledServiceException implements Exception {
  final String message;

  LocationDisabledServiceException(this.message);

  @override
  String toString() => 'LocationServiceDisabledException: $message';
}

class LocationPermissionDeniedException implements Exception {
  final String message;

  LocationPermissionDeniedException(this.message);

  @override
  String toString() => 'LocationPermissionDeniedException: $message';
}

class LocationPermissionPermanentDeniedException implements Exception {
  final String message;

  LocationPermissionPermanentDeniedException(this.message);

  @override
  String toString() => 'LocationPermissionPermanentDeniedException: $message';
}
