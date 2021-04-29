import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/core/theme/app_colors.dart';
import '../../../../app/pages/home/home_controller.dart';

class AddNoteButton extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.purple,
      child: Icon(
        Icons.add,
      ),
      onPressed: () {
        Get.toNamed('/note-detail');
      },
    );
  }
}
