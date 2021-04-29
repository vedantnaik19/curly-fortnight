import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/core/constants/asset_path.dart';
import 'package:stack_fin_notes/app/core/constants/widget_keys.dart';
import 'package:stack_fin_notes/app/core/theme/app_colors.dart';
import 'package:stack_fin_notes/app/pages/home/home_controller.dart';
import 'package:stack_fin_notes/app/shared/widgets/nothing_here.dart';
import 'package:stack_fin_notes/app/shared/widgets/user_avatar.dart';

class HomeDrawer extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
                child: Stack(
              children: [
                Container(
                  child: Opacity(
                    opacity: 0.1,
                    child: SvgPicture.asset(
                      AssetPath.notesSvg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      UserAvatar(radius: 24, key: WidgetKeys.DRAWER_AVATAR),
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          controller.displayName,
                          style: textTheme.bodyText1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          controller.email,
                          style: textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NothingHere(size: 100),
                SizedBox(height: 16),
                Text("Nothing here..."),
                SizedBox(height: 100),
              ],
            ),
          ),
          ListTile(
            leading: FlatButton.icon(
              onPressed: () {
                controller.onLogout();
              },
              icon: Icon(
                Icons.logout,
                color: AppColors.red,
              ),
              label: Text(
                "logOut".tr,
                style: textTheme.caption.copyWith(color: AppColors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
