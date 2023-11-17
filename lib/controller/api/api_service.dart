import 'api_controller.dart';

class APIService extends APIController {
  late APIController apiServiceProvider;

  static final APIService _instance = APIService._internal();

  APIService._internal();

  factory APIService({required APIController apiServiceProvider}) {
    _instance.apiServiceProvider = apiServiceProvider;
    return _instance;
  }
}
