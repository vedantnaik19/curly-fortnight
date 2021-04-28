import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stack_fin_notes/app/core/constants/asset_path.dart';

class NothingHere extends StatelessWidget {
  final double size;

  const NothingHere({Key key, @required this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size,
          width: size,
          child: SvgPicture.asset(
            AssetPath.voidSvg,
          ),
        ),
      ],
    );
  }
}
