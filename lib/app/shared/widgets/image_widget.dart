import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_controller.dart';

class ImageWidget extends GetView<AppController> {
  final String uri;
  ImageWidget({Key key, @required this.uri}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Uri.parse(uri).isAbsolute
        ? Image(
            image: CachedNetworkImageProvider(uri),
            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              return Container(
                width: double.maxFinite,
                height: 100,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        controller.hasConnection.value
                            ? ""
                            : "Unable to load image, check internet connectivity!",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: textTheme.caption),
                  ),
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
        : File(uri) != null
            ? Image.file(File(uri))
            : Container();
  }
}
