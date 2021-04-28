import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/core/constants/asset_path.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Hero(
      tag: 'logo',
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 36, left: 16, right: 16),
        child: Container(
          height: Get.width * 0.36,
          child: SvgPicture.asset(
            AssetPath.notesSvg,
          ),
        ),
      ),
    );
  }
}
