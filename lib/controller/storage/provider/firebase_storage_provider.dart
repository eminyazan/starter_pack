import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../storage_controller.dart';

class FirebaseStorageProvider extends StorageController {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;


}
