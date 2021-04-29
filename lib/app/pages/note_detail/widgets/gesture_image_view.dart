import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../app/pages/note_detail/note_detail_controller.dart';
import '../../../../app/utils/helper.dart';

class GestureImageView extends GetView<NoteDetailController> {
  final String imagePath;
  GestureImageView({@required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white54,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: PhotoView(
        imageProvider: Helper.isUrl(imagePath)
            ? NetworkImage(imagePath)
            : FileImage(
                File(imagePath),
              ),
      ),
    );
  }
}
