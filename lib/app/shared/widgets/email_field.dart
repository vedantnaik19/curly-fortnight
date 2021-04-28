// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:stack_fin_notes/app/core/theme/app_colors.dart';
// import 'package:stack_fin_notes/app/shared/utils/validators.dart';

// class EmailField extends GetView {
//   final TextEditingController textEditingController;

//   const EmailField({Key key, @required this.textEditingController})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: textEditingController,
//       keyboardType: TextInputType.emailAddress,
//       maxLines: 1,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       validator: (val) {
//         return Validators.email(val.trim()) ? null : 'validEmail'.tr;
//       },
//       decoration: InputDecoration(
//           hintText: 'email'.tr,
//           fillColor: AppColors.offWhite,
//           border: OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.circular(4),
//           ),
//           filled: true),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/core/theme/app_colors.dart';
import 'package:stack_fin_notes/app/shared/utils/validators.dart';

class EmailField extends GetView {
  final TextEditingController textEditingController;

  const EmailField({Key key, @required this.textEditingController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.emailAddress,
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        return Validators.email(val.trim()) ? null : 'validEmail'.tr;
      },
      decoration: InputDecoration(
        hintText: 'email'.tr,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.greyLight, width: 0.5),
        ),
      ),
    );
  }
}
