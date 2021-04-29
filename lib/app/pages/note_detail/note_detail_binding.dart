import 'package:get/get.dart';

import 'note_detail_controller.dart';

class NoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NoteDetailController());
  }
}
