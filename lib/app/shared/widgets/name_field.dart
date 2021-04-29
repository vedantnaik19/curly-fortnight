import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/core/theme/app_colors.dart';
import '../../../app/utils/validators.dart';
import '../../../app_controller.dart';

class NameField extends GetView<AppController> {
  final TextEditingController textEditingController;

  const NameField({Key key, @required this.textEditingController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        return Validators.string(val.trim()) ? null : 'validName'.tr;
      },
      decoration: InputDecoration(
        hintText: "name".tr,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.greyLight, width: 0.5),
        ),
      ),
    );
  }
}
