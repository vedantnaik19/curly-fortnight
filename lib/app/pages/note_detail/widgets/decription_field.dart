import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:stack_fin_notes/app/pages/note_detail/note_detail_controller.dart';

class DescriptionField extends GetView<NoteDetailController> {
  final int maxLines;

  const DescriptionField({@required this.maxLines});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextField(
      controller: controller.desController,
      style: textTheme.bodyText1,
      textCapitalization: TextCapitalization.sentences,
      maxLines: maxLines,
      autofocus: Get.arguments == null ? true : false,
      decoration: InputDecoration(
        hintText: 'description'.tr,
      ),
      onChanged: (val) {
        Debounce.milliseconds(400, controller.setDescription, [val.trim()]);
      },
    );
  }
}
