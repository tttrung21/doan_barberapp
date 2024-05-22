import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../skin/color_skin.dart';
import '../style/color.dart';

class FIcon extends StatelessWidget {
  FIcon({
    Key? key,
    required this.icon,
    this.color,
    this.size,
  })  : primaryColor = FColorSkin.primary,
        secondaryColor = FColorSkin.secondary1,
        super(key: key);

  /// string icon thông qua static field của class FIcons
  final String icon;

  /// tone màu icon thứ nhất [twotone]
  final Color primaryColor;

  /// tone màu icon thứ 2 [twotone]
  final Color secondaryColor;

  /// màu icon mặc định là màu grey10
  final Color? color;

  /// size icon, mặc định là 24
  final double? size;

  @override
  Widget build(BuildContext context) {
    final _effectiveColor = color ?? FColors.grey10;
    final _effectiveSize = size ?? 24;

    return SvgPicture.string(
      icon,
      height: _effectiveSize,
      width: _effectiveSize,
      colorFilter: ColorFilter.mode(_effectiveColor, BlendMode.srcIn),
    );
  }
}
