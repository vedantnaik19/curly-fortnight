import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/core/constants/asset_path.dart';
import 'package:stack_fin_notes/app/core/theme/app_colors.dart';
import 'package:stack_fin_notes/app/pages/login/login_controller.dart';
import 'package:stack_fin_notes/app/shared/widgets/email_field.dart';
import 'package:stack_fin_notes/app/shared/widgets/expanded_button.dart';
import 'package:stack_fin_notes/app/shared/widgets/google_button.dart';
import 'package:stack_fin_notes/app/shared/widgets/logo.dart';
import 'package:stack_fin_notes/app/shared/widgets/password_field.dart';

class LoginPage extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ListView(
                  children: [
                    SizedBox(
                      height: 64,
                    ),
                    Logo(),
                    buildBottomHalf(textTheme, context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomHalf(TextTheme textTheme, context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailField(textEditingController: _emailController),
          SizedBox(height: 8),
          PasswordField(textEditingController: _passController),
          SizedBox(height: 16),
          ExpandedButton(
            label: "login".tr,
            onTap: () {
              FocusScope.of(context).unfocus();
              if (_formKey.currentState.validate()) {
                controller.loginWEmailPassword(
                    _emailController.text, _passController.text);
              }
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.toNamed('/forgot-pass');
              },
              child: Text(
                'forgotPassword'.tr,
                style: textTheme.caption,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "or".tr,
              style: textTheme.caption,
            ),
          ),
          SizedBox(height: 16),
          GoogleButton(
            onTap: () {
              FocusScope.of(context).unfocus();
              controller.onGoogleSignIn();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Get.toNamed('/signup');
              },
              child: Text(
                'registerHere'.tr,
              ),
            ),
          )
        ],
      ),
    );
  }
}
