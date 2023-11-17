import 'dart:async';

import '../../model/location/app_location_model.dart';
import 'location_controller.dart';

class LocationService extends LocationController {
  late LocationController locationProvider;

  static final LocationService _instance = LocationService._internal();

  LocationService._internal();

  factory LocationService({
    required LocationController locationProvider,
  }) {
    _instance.locationProvider = locationProvider;
    return _instance;
  }

  static AppLocationModel miaLocation = AppLocationModel(lat: 39.7796066, long: 32.808473);

  @override
  Future<AppLocationModel> getUserLocation() async {
    return await locationProvider.getUserLocation();
  }

  @override
  Future<void> askLocationPermission() async {
    await locationProvider.askLocationPermission();
  }

  @override
  Future<bool> checkLocationPermission() async {
    return await locationProvider.checkLocationPermission();
  }
}
