import 'package:get_it/get_it.dart';

import '../api/api_service.dart';
import '../api/provider/http_api_provider.dart';
import '../local_database/local_database.dart';
import '../local_database/provider/hive/hive_provider.dart';
import '../location/location_service.dart';
import '../location/provider/geolocator_provider.dart';

final serviceLocator = GetIt.instance;

void setupLocators() {
  //LocalDatabase class singleton
  serviceLocator.registerLazySingleton(
    () => LocalDatabase(
      localDatabaseProvider: HiveProvider(),
    ),
  );


  //LocalDatabase class singleton
  serviceLocator.registerLazySingleton(
    () => APIService(
      apiServiceProvider: HttpApiProvider(),
    ),
  );


  //LocalDatabase class singleton
  serviceLocator.registerLazySingleton(
        () => LocationService(
      locationProvider: GeoLocationProvider(),
    ),
  );



}
