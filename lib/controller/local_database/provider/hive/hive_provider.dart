import 'package:hive_flutter/hive_flutter.dart';

import '../../local_database_consts.dart';
import '../../local_database_controller.dart';

class HiveProvider implements LocalDatabaseController {
  //TODO open it later
  //late Box<UserModel> _userBox;

  @override
  Future<void> initialize() async {
    await Hive.initFlutter();
    //Hive.registerAdapter(UserModelAdapter());
    // _userBox = await Hive.openBox<LoginModel>(LOCAL_USER_DB);
  }
}
