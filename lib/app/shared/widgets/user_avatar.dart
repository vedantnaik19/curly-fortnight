import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_controller.dart';

class UserAvatar extends GetView<AppController> {
  final double radius;
  const UserAvatar({Key key, @required this.radius});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CircleAvatar(
        child: controller.dbUser.value?.photoUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  controller.dbUser.value.photoUrl,
                  fit: BoxFit.contain,
                ),
              )
            : Text(
                (controller.dbUser.value?.name ?? "?")
                    .substring(0, 1)
                    .capitalize,
                maxLines: 1,
              ),
        maxRadius: radius,
      ),
    );
  }
}
