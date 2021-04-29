import 'package:get/get.dart';
import 'package:stack_fin_notes/app/shared/services/sync_service.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SyncService>(() => SyncService());
    Get.put(HomeController());
  }
}
