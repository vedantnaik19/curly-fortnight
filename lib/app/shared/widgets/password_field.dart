import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/core/theme/app_colors.dart';
import '../../../app/utils/validators.dart';
import '../../../app_controller.dart';

class PasswordField extends GetView<AppController> {
  final TextEditingController textEditingController;

  const PasswordField({Key key, @required this.textEditingController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        return Validators.password(val.trim()) ? null : 'validPassword'.tr;
      },
      decoration: InputDecoration(
        hintText: 'password'.tr,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.greyLight, width: 0.5),
        ),
      ),
    );
  }
}
