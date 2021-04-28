import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/shared/widgets/loader.dart';

/// Service to display snackbars, loaders, bottomsheet, etc.
class UiService extends GetxService {
  showSnack(String message) {
    Get.snackbar(
      null,
      null,
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black.withOpacity(0.9),
      colorText: Colors.white,
      borderRadius: 0,
      margin: EdgeInsets.all(0),
      maxWidth: double.infinity,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  showLoader(bool val, [String msg = '']) {
    if (Get.isDialogOpen && !val) {
      Get.back();
    } else if (val) {
      if (Get.isDialogOpen) Get.back();
      Get.dialog(
          WillPopScope(
              child: SimpleDialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        msg,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Loader()
                    ],
                  ),
                ],
              ),
              // ignore: missing_return
              onWillPop: () {}),
          barrierDismissible: false,
          barrierColor: Colors.white38);
    }
  }
}
