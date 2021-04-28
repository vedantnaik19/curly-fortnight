import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/core/services/connectivity_service.dart';

class ImageWidget extends StatelessWidget {
  final String uri;
  final ConnectivityService _connectivityService = Get.find();

  ImageWidget({Key key, @required this.uri}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Uri.parse(uri).isAbsolute
        ? Image.network(
            uri,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              return Container(
                width: double.maxFinite,
                height: 100,
                child: Center(
                  child: Text(
                      _connectivityService.hasConnection
                          ? "Failed to load image!"
                          : "Unable to load image, check internet connectivity!",
                      maxLines: 2,
                      style: textTheme.caption),
                ),
              );
            },
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: double.maxFinite,
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                ),
              );
            },
          )
        : Image.file(File(uri));
  }
}
