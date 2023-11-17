import 'dart:io';

import 'storage_controller.dart';

class StorageService implements StorageController {
  late StorageController storageProvider;

  static final StorageService _instance = StorageService._internal();

  StorageService._internal();

  factory StorageService({required StorageController storageProvider}) {
    _instance.storageProvider = storageProvider;
    return _instance;
  }


}
