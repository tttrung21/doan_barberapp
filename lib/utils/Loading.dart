import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../components/skin/color_skin.dart';

class LoadingCore {
  static void loadingDialogIos(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Color(0xff1C2430).withOpacity(0.3),
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: FColorSkin.transparent,
            elevation: 0.0,
            content: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SpinKitRipple(
                  color: FColorSkin.primary,
                  size: 100,
                  borderWidth: 40,
                ),
                SpinKitRing(
                  color: FColorSkin.primary,
                  size: 60,
                  lineWidth: 4,
                ),
                SpinKitPulse(
                  color: FColorSkin.primary,
                  size: 80,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: FColorSkin.white,
                    ),
                    child: SvgPicture.asset(
                      'assets/SVG/barber.svg',
                      colorFilter: ColorFilter.mode(FColorSkin.primary, BlendMode.srcIn),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget loading() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 48.0,
                height: 48.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        itemCount: 6,
      ),
    ),
  );
}
