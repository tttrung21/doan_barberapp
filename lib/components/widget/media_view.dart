import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../skin/color_skin.dart';
import '../style/box_style.dart';

class FMediaView extends StatelessWidget {
  const FMediaView({
    Key? key,
    this.size = FBoxSize.size48,
    this.shape = FBoxShape.round,
    required this.child,
    this.backgroundColor = FColorSkin.grey3,
  }) : super(key: key);

  final FBoxShape shape;
  final FBoxSize size;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final _borderRadius = shape == FBoxShape.circle
        ? size.circleRadius
        : shape == FBoxShape.round
            ? size.roundRadius
            : BorderRadius.zero;

    return Container(
      width: size.value,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        color: backgroundColor,
      ),
      child: AspectRatio(
        aspectRatio: size.ratioValue,
        child: ClipRRect(
          borderRadius: _borderRadius,
          child: child,
        ),
      ),
    );
  }
}
