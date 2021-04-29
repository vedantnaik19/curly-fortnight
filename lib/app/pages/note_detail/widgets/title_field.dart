import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import '../note_detail_controller.dart';

class TitleField extends GetView<NoteDetailController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextField(
      controller: controller.titleController,
      style: textTheme.headline6,
      textCapitalization: TextCapitalization.sentences,
      maxLines: 1,
      onChanged: (val) {
        Debounce.milliseconds(400, controller.setTitle, [val.trim()]);
      },
      decoration: InputDecoration(
        hintText: 'title'.tr,
        hintStyle: textTheme.headline6.copyWith(color: textTheme.caption.color),
      ),
    );
  }
}
