import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/core/services/ui_service.dart';

class ConnectivityService extends GetxService {
  final UiService _uiService = Get.find();
  bool _hasConnection = false;
  StreamSubscription _subscription;
  bool get hasConnection => _hasConnection;
  @override
  void onInit() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        _hasConnection = true;
      } else {
        _uiService.showSnack("You are offline!");
        _hasConnection = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
