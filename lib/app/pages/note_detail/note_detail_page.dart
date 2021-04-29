import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './widgets/decription_field.dart';
import './widgets/title_field.dart';
import '../../../app/core/theme/app_colors.dart';
import '../../../app/pages/note_detail/widgets/bottom_row.dart';
import '../../../app/pages/note_detail/widgets/gesture_image_view.dart';
import '../../../app/shared/widgets/image_widget.dart';
import 'note_detail_controller.dart';

class NoteDetailPage extends GetView<NoteDetailController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back(closeOverlays: true);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(
                () => AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: !(["", null].contains(controller.note.value.image))
                        ? buildListView(textTheme)
                        : buildColumnView(textTheme)),
              ),
            ),
            BottomRow()
          ],
        ),
      ),
    );
  }

  Widget buildListView(TextTheme textTheme) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  controller.onRemoveImage();
                },
                child: Text(
                  "removeImage".tr,
                  style: textTheme.caption.copyWith(color: AppColors.red),
                )),
          ),
        ),
        InkWell(
            onTap: () {
              Get.to(
                () => GestureImageView(imagePath: controller.note.value.image),
              );
            },
            child: ImageWidget(uri: controller.note.value.image)),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TitleField(),
              DescriptionField(maxLines: 4),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildColumnView(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          TitleField(),
          Expanded(
            child: DescriptionField(maxLines: 10),
          ),
        ],
      ),
    );
  }
}
