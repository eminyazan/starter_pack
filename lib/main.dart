import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'controller/dependency_injection/service_locator.dart';
import 'controller/internet/internet_controller.dart';
import 'controller/internet/provider/connectivity_plus_provider.dart';
import 'controller/local_database/local_database.dart';
import 'model/exception/app_exceptions.dart';
import 'view/components/alert/app_alert_dialog.dart';
import 'view/pages/loading/loading_page_builder.dart';
import 'view/pages/splash/splash_page.dart';
import 'view/resources/colors/app_colors.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  //Exception handling by globally
  runZonedGuarded<Future<void>>(() async {
    //top level widget and service creator
    WidgetsFlutterBinding.ensureInitialized();

    // singleton services,repo,trackers
    setupLocators();

    LocalDatabase localDb = serviceLocator.get<LocalDatabase>();
    await localDb.initialize();

    await dotenv.load(fileName: ".env");

    //use app only portrait screen orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) {
      runApp(
        MultiProvider(
          providers: [
            StreamProvider<NetworkResult>(
              create: (context) => ConnectivityPlusProvider().networkResultController.stream,
              initialData: NetworkResult.offline,
            ),
          ],
          child: const MyApp(),
        ),
      );
    });
  }, (Object error, StackTrace stack) async {
    //related with dart errors
    setBusy(false);
    if (error is AppException) {
      await AppAlert.show(description: error.message!);
    } else if (error is SocketException || error is HttpException) {
      await AppAlert.show(description: 'Bağlantı kurulamadı yapmak istediğiniz işlemi tekrar deneyin');
    } else {
      await AppAlert.show(description: 'Beklenmeyen bir hata oluştu\n\n${error.toString()}');
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Waste',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kcLightModeMain),
        useMaterial3: true,
      ),
      builder: LoadingPageBuilder.init(),
      home: const SplashPage(),
    );
  }
}
