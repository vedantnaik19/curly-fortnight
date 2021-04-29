import 'package:flutter/material.dart';
import '../../../app/core/theme/app_colors.dart';

class ExpandedButton extends StatelessWidget {
  final label;
  final Function onTap;

  const ExpandedButton({Key key, @required this.label, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        elevation: 1,
        onPressed: () {
          onTap();
        },
        child: Text(
          label,
          style: textTheme.subtitle1.copyWith(color: Colors.white),
        ),
        color: AppColors.purple.withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
