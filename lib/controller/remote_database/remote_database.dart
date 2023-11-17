
import 'remote_database_controller.dart';

class RemoteDatabase implements RemoteDatabaseController {
  late RemoteDatabaseController remoteDatabaseProvider;

  static final RemoteDatabase _instance = RemoteDatabase._internal();

  RemoteDatabase._internal();

  factory RemoteDatabase({required RemoteDatabaseController remoteDatabaseProvider}) {
    _instance.remoteDatabaseProvider = remoteDatabaseProvider;
    return _instance;
  }

  @override
  Future<void> initializeDB() async {
    await remoteDatabaseProvider.initializeDB();
  }


}
