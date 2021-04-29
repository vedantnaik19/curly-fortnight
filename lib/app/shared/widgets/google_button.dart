import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../app/core/constants/asset_path.dart';
import '../../../app/core/theme/app_colors.dart';

class GoogleButton extends StatelessWidget {
  final Function onTap;

  const GoogleButton({Key key, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RaisedButton(
      padding: const EdgeInsets.all(12),
      elevation: 0.2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      onPressed: onTap,
      color: AppColors.offWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 24,
            width: 24,
            child: SvgPicture.asset(
              AssetPath.googleSvg,
            ),
          ),
          SizedBox(width: 8),
          Text(
            'continueWGoogle'.tr,
            style: textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
