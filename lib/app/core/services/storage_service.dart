import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:stack_fin_notes/app/core/constants/app_constants.dart';

class StorageService extends GetxService {
  LazyBox _box;
  LazyBox get box => _box;

  @override
  void onInit() {
    _box = Hive.lazyBox(AppContants.NOTES_BOX);
    super.onInit();
  }

  Future<void> clearStorage() async {
    try {
      await _box.clear();
    } catch (e) {
      print('StorageService: $e');
    }
  }
}
