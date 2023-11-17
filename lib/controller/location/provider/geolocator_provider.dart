import 'package:geolocator/geolocator.dart';

import '../../../controller/location/location_controller.dart';
import '../../../model/location/app_location_model.dart';

class GeoLocationProvider extends LocationController {
  @override
  Future<bool> checkLocationPermission() async {

    bool serviceEnabled;
    LocationPermission permission;

    // first we check for phone location service is enable
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();

    // denied or denied forever means is false
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Future<AppLocationModel> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    AppLocationModel appLocationModel = AppLocationModel(lat: position.latitude, long: position.longitude);
    return appLocationModel;
  }

  @override
  Future<void> askLocationPermission() async {
    // we ask location permıssıon to user
    await Geolocator.requestPermission();
  }
}
