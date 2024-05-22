import 'package:flutter/material.dart';

import '../skin/typo_skin.dart';
import '../style/color.dart';


class FAppBar extends StatefulWidget implements PreferredSizeWidget {
  FAppBar({
    Key? key,
    this.leading,
    this.title,
    this.actions,
    this.centerTitle = false,
    this.leadingWidth = 48 + 16.0,
    this.brightness = Brightness.light,
    this.backgroundColor = FColors.grey1,
    this.bottom,
    this.shape,
    this.toolbarHeight = 48,
    this.elevation = 0,
    this.automaticallyImplyLeading = false,
    this.flexibleSpace,
    this.titleSpacing,
  }) : super(key: key);

  FAppBar.modal({
    Key? key,
    this.leading,
    this.title,
    this.actions,
    this.centerTitle = false,
    this.leadingWidth,
    this.brightness = Brightness.light,
    this.backgroundColor = FColors.grey1,
    this.bottom,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    this.toolbarHeight = 56,
    this.elevation = 0,
    this.automaticallyImplyLeading = false,
    this.flexibleSpace,
    this.titleSpacing,
  });

  final Brightness? brightness;
  final Color? backgroundColor;
  final double? leadingWidth;
  final double? toolbarHeight;
  final double? elevation;
  final bool? centerTitle;
  final bool? automaticallyImplyLeading;
  final ShapeBorder? shape;
  final Widget? leading;
  final Widget? title;
  final Widget? flexibleSpace;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? titleSpacing;

  @override
  _FAppBarState createState() => _FAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? 0 + (bottom?.preferredSize.height ?? 0));
}

class _FAppBarState extends State<FAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: widget.titleSpacing,
      backgroundColor: widget.backgroundColor,
      // brightness: widget.brightness,
      automaticallyImplyLeading: widget.automaticallyImplyLeading ?? false,
      toolbarHeight: widget.toolbarHeight,
      leadingWidth: widget.leadingWidth,
      elevation: widget.elevation,
      leading: widget.leading ?? SizedBox(),
      title: widget.title == null
          ? null
          : DefaultTextStyle(
              style: FTypoSkin.buttonText1.copyWith(color: FColors.grey9),
              child: widget.title ?? SizedBox(),
            ),
      actions: widget.actions,
      bottom: widget.bottom,
      centerTitle: widget.centerTitle,
      shape: widget.shape,
      flexibleSpace: widget.flexibleSpace,
    );
  }
}
