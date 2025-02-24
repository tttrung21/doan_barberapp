
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doan_barberapp/components/skin/typo_skin.dart';
import 'package:doan_barberapp/shared/constant.dart';
import 'package:flutter/material.dart';

import '../../../components/skin/color_skin.dart';
import '../../../generated/l10n.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(autoPlay: false,viewportFraction: 1 ,height: 140),
      items: [
        Container(
          height: 100,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                FColorSkin.primary,
                FColorSkin.secondarySub1
              ],
            ),
          ),
          child: Text.rich(
            TextSpan(
              style: FTypoSkin.title4.copyWith(color: FColorSkin.white),
              children: [
                TextSpan(text: '${S.of(context).home_DatLichNgay}\n'),
                TextSpan(
                  text: shopName,
                  style: FTypoSkin.largeTitle
                ),
              ],
            ),
          ),
        ),
        Image.asset('assets/images/banner.jpg',fit: BoxFit.fill,)
      ],
    );
  }
}
