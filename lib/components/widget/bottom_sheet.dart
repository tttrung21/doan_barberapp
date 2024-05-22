
import 'package:flutter/material.dart';

import '../../utils/DeviceUtils.dart';
import '../skin/color_skin.dart';

Future<dynamic> showFMBS({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    ),
  ),
  Clip? clipBehavior,
  bool isScrollControlled = true,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  double? height,
  RouteSettings? routeSettings,
}) {
  return showModalBottomSheet(
      elevation: 0,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: isScrollControlled,
      context: context,
      useRootNavigator: useRootNavigator,
      barrierColor: FColorSkin.title.withOpacity(0.6),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        var insetsHeight = 0.0;
        if (height != null) {
          final totalHeight = height + MediaQuery.of(context).viewInsets.bottom;
          insetsHeight = totalHeight >= DeviceUtils.safeHeight
              ? DeviceUtils.safeHeight - height
              : MediaQuery.of(context).viewInsets.bottom;
        }

        return Container(
          height: height != null ? height + insetsHeight : null,
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Builder(builder: builder)),
        );
      });
}
