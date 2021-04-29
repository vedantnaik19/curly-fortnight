import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/pages/login/login_controller.dart';
import '../../../../app/shared/widgets/email_field.dart';
import '../../../../app/shared/widgets/expanded_button.dart';
import '../../../../app/shared/widgets/logo.dart';

class ForgotPassPage extends GetView<LoginController> {
  final _emailCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                Form(
                    key: _formKey,
                    child: EmailField(textEditingController: _emailCont)),
                SizedBox(
                  height: 16,
                ),
                ExpandedButton(
                  label: "passReset".tr,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState.validate()) {
                      controller.forgotPassword(_emailCont.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
