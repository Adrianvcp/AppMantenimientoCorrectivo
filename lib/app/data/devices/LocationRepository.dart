import 'package:app_manteni_correc/app/domain/repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepositoryImpl implements LocationRepository {

  // Future<bool> checkisEnabledService() async {
  //   return await Geolocator.isLocationServiceEnabled();
  // }


  @override
  Future<Position> getCurrentUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationDisabledServiceException('Location Services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionDeniedException('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionPermanentDeniedException('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
  
  @override
  Future<bool> checkisEnabledService() {
    return Geolocator.isLocationServiceEnabled();
  }

}
