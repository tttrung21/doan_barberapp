import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../skin/color_skin.dart';
import '../skin/typo_skin.dart';
import '../style/icon_data.dart';
import 'icon.dart';

class WSnackBar {
  Duration? duration;
  Color? backgroundColor;
  FIcon? icon;
  Function? onTap;
  Widget? action;
  Widget? message;
  double? borderRadius;
  bool haveBottomBtn;
  EdgeInsets? margin;

  WSnackBar({
    this.duration,
    this.backgroundColor,
    this.icon,
    this.onTap,
    this.action,
    this.message,
    this.borderRadius,
    this.margin,
    this.haveBottomBtn = false,
  });
}

Material coreUISnackBar(WSnackBar snackBar) {
  return Material(
    color: FColorSkin.transparent,
    child: Container(
      height: 48,
      margin: snackBar.margin ?? EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: snackBar.backgroundColor, borderRadius: BorderRadius.circular(snackBar.borderRadius ?? 8.0)),
      child: Center(
          child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, snackBar.action != null ? 0 : 16, 0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: snackBar.icon,
            ),
            SizedBox(width: 14),
            Expanded(child: snackBar.message ?? SizedBox()),
            snackBar.action ?? SizedBox(),
          ],
        ),
      )),
    ),
  );
}

BackButtonBehavior backButtonBehavior = BackButtonBehavior.none;
Duration animatedDurationDefault = Duration(milliseconds: 850);
Duration durationDefault = Duration(milliseconds: 2500);

void wSnackBarInTop(WSnackBar snackBar) => BotToast.showCustomNotification(
    animationDuration: animatedDurationDefault,
    animationReverseDuration: animatedDurationDefault,
    duration: snackBar.duration ?? durationDefault,
    backButtonBehavior: backButtonBehavior,
    toastBuilder: (cancel) {
      return coreUISnackBar(snackBar);
    },
    enableSlideOff: false,
    onlyOne: false,
    crossPage: false);

void wSnackBarInBottom(WSnackBar snackBar) => BotToast.showCustomText(
      animationDuration: animatedDurationDefault,
      animationReverseDuration: animatedDurationDefault,
      duration: snackBar.duration ?? durationDefault,
      backButtonBehavior: backButtonBehavior,
      toastBuilder: (cancel) {
        return coreUISnackBar(snackBar);
      },
      align: Alignment(-1.0, snackBar.haveBottomBtn ? 0.8 : 0.9),
    );

Future<void> wCustomSnackBar({
  required String title,
  String? icon,
  Color? backColor,
  Color? iconColor,
  VoidCallback? onTap,
  Duration? duration,
  bool isBottom = false,
  Widget? action,
  double? radius,
  bool haveBottomBtn = false,
}) async {
  isBottom
      ? wSnackBarInBottom(
          WSnackBar(
            duration: duration,
            backgroundColor: backColor,
            borderRadius: radius,
            onTap: onTap,
            icon: icon == null
                ? null
                : FIcon(
                    icon: icon,
                    size: 24,
                    color: iconColor ?? FColorSkin.white,
                  ),
            message: Text(
              title,
              style: FTypoSkin.bodyText2.copyWith(color: FColorSkin.white, height: 0),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            action: action,
            haveBottomBtn: haveBottomBtn,
          ),
        )
      : wSnackBarInTop(
          WSnackBar(
            duration: duration,
            backgroundColor: backColor,
            borderRadius: radius,
            onTap: onTap,
            icon: icon == null
                ? null
                : FIcon(
                    icon: icon,
                    size: 24,
                    color: iconColor ?? FColorSkin.white,
                  ),
            message: Text(
              title,
              style: TextStyle(
                color: FColorSkin.grey1,
                fontSize: 14,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            action: action,
          ),
        );
}

class SnackBarCore {
  static Future<void> internet({
    String title = '',
    VoidCallback? onTap,
    bool isBottom = true,
    Widget? action,
  }) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: FColorSkin.error,
        icon: FOutlined.cloud_light,
        iconColor: FColorSkin.grey1,
        isBottom: isBottom,
        action: action);
  }

  static Future<void> customSnackBar({
    String title = '',
    VoidCallback? onTap,
    bool isBottom = true,
    Color? backColor,
    Color? iconColor,
    String? icon,
    Widget? action,
  }) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: backColor,
        icon: icon,
        iconColor: iconColor,
        isBottom: isBottom,
        action: action);
  }

  static Future<void> info({
    String title = '',
    VoidCallback? onTap,
    Duration? duration,
    bool isBottom = true,
    Widget? action,
    bool haveBottomBtn = false,
  }) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        duration: duration,
        backColor: FColorSkin.primary,
        icon: FFilled.c_info,
        iconColor: FColorSkin.grey1,
        isBottom: isBottom,
        haveBottomBtn: haveBottomBtn,
        action: action);
  }

  static Future<void> success({
    String title = '',
    VoidCallback? onTap,
    Duration? duration,
    String iconSnackBar = FFilled.c_check,
    bool isBottom = true,
    bool haveBottomBtn = false,
    Widget? action,
  }) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: FColorSkin.success,
        icon: iconSnackBar,
        duration: duration,
        isBottom: isBottom,
        haveBottomBtn: haveBottomBtn,
        action: action);
  }

  static Future<void> fail({
    String title = '',
    VoidCallback? onTap,
    String iconSnackBar = FFilled.c_remove,
    Color colorSnackBar = FColorSkin.error,
    bool isBottom = true,
    bool haveBottomBtn = false,
    Widget? action,
  }) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: colorSnackBar,
        icon: iconSnackBar,
        iconColor: FColorSkin.grey1,
        haveBottomBtn: haveBottomBtn,
        isBottom: isBottom,
        action: action);
  }

  static Future<void> warning({
    String title = '',
    VoidCallback? onTap,
    bool isBottom = true,
    bool haveBottomBtn = false,
    Widget? action,
  }) {
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: FColorSkin.warning,
        icon: FFilled.warning_sign,
        iconColor: FColorSkin.grey1,
        isBottom: isBottom,
        haveBottomBtn: haveBottomBtn,
        action: action);
  }

  static Future<void> copyContent({
    required String content,
    String title = '',
    VoidCallback? onTap,
    bool isBottom = true,
    Widget? action,
  }) async {
    await FlutterClipboard.copy(content);
    return wCustomSnackBar(
        title: title,
        onTap: onTap,
        backColor: FColorSkin.info,
        icon: FFilled.c_check,
        iconColor: FColorSkin.grey1,
        isBottom: isBottom,
        action: action);
  }
}
