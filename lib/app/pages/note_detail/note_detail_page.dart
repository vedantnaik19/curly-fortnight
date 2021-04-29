import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
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
        body: Hero(
          tag: controller.note.value.id,
          child: Column(
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
              TextField(
                controller: controller.titleController,
                style: textTheme.headline6,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 1,
                onChanged: (val) {
                  Debounce.milliseconds(400, controller.setTitle, [val.trim()]);
                },
                decoration: InputDecoration(
                  hintText: 'title'.tr,
                  hintStyle: textTheme.headline6
                      .copyWith(color: textTheme.caption.color),
                ),
              ),
              TextField(
                controller: controller.desController,
                style: textTheme.bodyText1,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'description'.tr,
                ),
                onChanged: (val) {
                  Debounce.milliseconds(
                      400, controller.setDescription, [val.trim()]);
                },
              ),
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
          TextField(
            controller: controller.titleController,
            style: textTheme.headline6,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 1,
            onChanged: (val) {
              Debounce.milliseconds(400, controller.setTitle, [val.trim()]);
            },
            decoration: InputDecoration(
              hintText: 'title'.tr,
              hintStyle:
                  textTheme.headline6.copyWith(color: textTheme.caption.color),
            ),
          ),
          Expanded(
              child: TextField(
            controller: controller.desController,
            style: textTheme.bodyText1,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 10,
            autofocus: Get.arguments == null ? true : false,
            decoration: InputDecoration(
              hintText: 'description'.tr,
            ),
            onChanged: (val) {
              Debounce.milliseconds(
                  400, controller.setDescription, [val.trim()]);
            },
          )),
        ],
      ),
    );
  }
}
