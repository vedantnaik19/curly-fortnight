import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/pages/login/login_controller.dart';
import 'package:stack_fin_notes/app/shared/widgets/email_field.dart';
import 'package:stack_fin_notes/app/shared/widgets/expanded_button.dart';
import 'package:stack_fin_notes/app/shared/widgets/logo.dart';
import 'package:stack_fin_notes/app/shared/widgets/name_field.dart';
import 'package:stack_fin_notes/app/shared/widgets/password_field.dart';

class SignUpPage extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _nameCont = TextEditingController();
  final _emailCont = TextEditingController();
  final _passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back(closeOverlays: true);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                Logo(),
                buildBottomHalf(textTheme, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomHalf(TextTheme textTheme, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          NameField(textEditingController: _nameCont),
          SizedBox(height: 12),
          EmailField(textEditingController: _emailCont),
          SizedBox(height: 12),
          PasswordField(textEditingController: _passCont),
          SizedBox(height: 24),
          ExpandedButton(
            label: "signup".tr,
            onTap: () {
              FocusScope.of(context).unfocus();
              if (_formKey.currentState.validate()) {
                controller.signupWEmailPassword(
                    _emailCont.text, _passCont.text, _nameCont.text);
              }
            },
          ),
        ],
      ),
    );
  }
}
