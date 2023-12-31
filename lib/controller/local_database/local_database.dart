import 'local_database_controller.dart';

class LocalDatabase implements LocalDatabaseController {
  late LocalDatabaseController localDatabaseProvider;

  static final LocalDatabase _instance = LocalDatabase._internal();

  LocalDatabase._internal();

  factory LocalDatabase({required LocalDatabaseController localDatabaseProvider}) {
    _instance.localDatabaseProvider = localDatabaseProvider;
    return _instance;
  }

  @override
  Future<void> initialize() async => await localDatabaseProvider.initialize();
}
