import 'dart:async';

import '../../model/location/app_location_model.dart';

abstract class LocationController {

  Future<AppLocationModel> getUserLocation();

  Future<bool> checkLocationPermission();

  Future<void> askLocationPermission();
}
