import 'package:flutter/material.dart';

Widget animatedChangeWidget({Widget? showWidget, Widget? seWid, bool isChange = false, int time = 300}) {
  return AnimatedCrossFade(
    duration: Duration(milliseconds: time),
    alignment: Alignment.center,
    firstChild: showWidget ?? SizedBox(),
    secondChild: seWid ??
        Container(
          height: 0.0,
        ),
    crossFadeState: (showWidget != null && isChange) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
  );
}
