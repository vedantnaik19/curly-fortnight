import 'package:get/get.dart';

import 'home_controller.dart';

/// Used for putting dependencies
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    // Get.lazyPut<HomeController>(() => HomeController());
  }
}
