import 'package:get/get.dart';
import './app/core/services/auth_service.dart';
import './app/data/services/firestore_service.dart';
import './app/data/services/cloud_storage_service.dart';
import './app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => FirestoreService());
    Get.lazyPut(() => CloudStorageService());
    Get.put(AppController());
  }
}
