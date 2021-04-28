import 'package:get/get.dart';
import 'package:stack_fin_notes/app/core/services/auth_service.dart';
import 'package:stack_fin_notes/app/core/services/connectivity_service.dart';
import 'package:stack_fin_notes/app/core/services/storage_service.dart';
import 'package:stack_fin_notes/app/data/services/firestore_service.dart';
import 'package:stack_fin_notes/app/shared/services/sync_Image_service.dart';

import 'app/core/services/ui_service.dart';
import 'app/data/services/cloud_storage_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UiService());
    Get.put(ConnectivityService());
    Get.put(StorageService());
    Get.put(AuthService());

    Get.put(FirestoreService());
    Get.put(CloudStorageService());

    Get.put(SyncImageService());
  }
}
