import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/pages/note_detail/note_detail_controller.dart';
import '../../../../app/utils/helper.dart';

class BottomRow extends GetView<NoteDetailController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.add_photo_alternate),
          onPressed: () {
            FocusScope.of(context).unfocus();
            controller.pickImage();
          },
        ),
        Expanded(
          child: Obx(
            () => Text(
              controller.note.value.editedAt != null
                  ? "editedAt".tr +
                      " " +
                      Helper.formatDate(controller.note.value.editedAt)
                  : "",
              textAlign: TextAlign.center,
              style: textTheme.caption,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete_rounded),
          onPressed: () {
            controller.onDeleteNote();
          },
        )
      ],
    );
  }
}
