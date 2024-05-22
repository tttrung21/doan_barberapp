import 'package:flutter/material.dart';

import '../skin/color_skin.dart';

class FDivider extends StatelessWidget {
  const FDivider({
    Key? key,
    this.color = FColorSkin.border1,
    this.endIndent,
    this.height = 1.0,
    this.indent,
    this.thickness = 1,
  }) : super(key: key);

  final Color color;
  final double? endIndent;
  final double height;
  final double? indent;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      key: key,
      color: color,
      endIndent: endIndent,
      height: height,
      indent: indent,
      thickness: thickness,
    );
  }
}
