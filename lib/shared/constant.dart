

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../components/skin/color_skin.dart';
import '../components/skin/typo_skin.dart';
import '../components/style/box_style.dart';
import '../components/style/icon_data.dart';
import '../components/widget/app_bar.dart';
import '../components/widget/filled_button.dart';
import '../components/widget/icon.dart';
import '../components/widget/media_view.dart';
import '../generated/l10n.dart';

const String shopName = 'The Sharp & Sheared Lounge';

const List<String> timeSlot = [
  '9:00',
  '9:30',
  '10:00',
  '10:30',
  '11:00',
  '11:30',
  '12:00',
  '12:30',
  '13:00',
  '13:30',
  '14:00',
  '14:30',
  '15:00',
  '15:30',
  '16:00',
  '16:30',
];

enum EnumGender { male, female }

AspectRatio BuildImage({
  required double ratio,
  required String url,
  bool isShowtext = false,
  double radius = 6,
}) {
  return AspectRatio(
    aspectRatio: ratio,
    child: CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => BuildShimmer(),
      errorWidget: (context, url, error) => BuildErrorImage(
        isShowtext,
        context,
      ),
    ),
  );
}

Shimmer BuildShimmer({Widget? child}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: child ??
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: FColorSkin.white,
          ),
        ),
  );
}

Material BuildErrorImage(
    bool isShowText,
    BuildContext context, {
      Color backgroundColor = FColorSkin.grey3,
      double radius = 6,
    }) {
  return Material(
    child: Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FIcon(
              icon: FFilled.image,
              size: 32,
              color: FColorSkin.subtitle,
            ),
            if (isShowText)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Loi tai anh',
                  style: FTypoSkin.bodyText2.copyWith(color: FColorSkin.body),
                  textAlign: TextAlign.center,
                ),
              )
          ],
        ),
      ),
    ),
  );
}


Container BuildAvatarWithUrl(String url, {double size = 40, Color? borderColor}) {
  return Container(
    width: size,
    height: size,
    padding: EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: borderColor ?? FColorSkin.transparent,
      borderRadius: BorderRadius.circular(size),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => BuildShimmer(),
        errorWidget: (context, url, error) => FMediaView(
          shape: FBoxShape.circle,
          child: Center(
            child: Image.asset(
              'assets/images/placeholder_avatar.png',
              width: 100,
              fit: BoxFit.cover,
            )
          ),
        ),
      ),
    ),
  );
}

Widget BuildEmptyData({required String title, String? subtitle}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FIcon(
          icon: FFilled.history,
          size: 120,
          color: FColorSkin.disable2,
        ),
        SizedBox(height: 48),
        Text(
          title,
          style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
          textAlign: TextAlign.center,
        ),
        if (subtitle?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              subtitle ?? '',
              style: FTypoSkin.bodyText1.copyWith(color: FColorSkin.body),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    ),
  );
}

Widget BuildEmptySearch(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FIcon(
          icon: FFilled.not_found,
          size: 120,
          color: FColorSkin.disable2,
        ),
        SizedBox(height: 48),
        Text(
          S.of(context).common_KhongCoKQ,
          style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            S.of(context).common_TimKiemKhac,
            style: FTypoSkin.bodyText1.copyWith(color: FColorSkin.body),
          ),
        ),
      ],
    ),
  );
}

Scaffold showLangsBTS(BuildContext context, bool isVietnamese) {
  return Scaffold(
    backgroundColor: FColorSkin.white,
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(64.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 4),
            child: Container(
              height: 4,
              width: 32,
              decoration: BoxDecoration(
                color: Color(0xffEAEAEA),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          FAppBar(
            title: Text(
              S.of(context).common_ChonNgonNgu,
              style: FTypoSkin.title3.copyWith(height: 0),
            ),
            centerTitle: true,
            leading: FFilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: FColorSkin.transparent,
              child: FIcon(
                icon: FOutlined.e_remove,
                color: FColorSkin.subtitle,
              ),
            ),
          ),
        ],
      ),
    ),
    body: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop(true);
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            color: FColorSkin.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Icon_Flag_VN.png',
                  width: 32,
                  height: 32,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    S.of(context).common_TiengViet,
                    style: FTypoSkin.label1.copyWith(color: FColorSkin.label, height: 0),
                  ),
                ),
                if (isVietnamese)
                  FIcon(
                    icon: FOutlined.check,
                    size: 20,
                    color: FColorSkin.primary,
                  )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop(false);
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            color: FColorSkin.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Icon_Flag_EN.png',
                  width: 33,
                  height: 33,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    S.of(context).common_TiengAnh,
                    style: FTypoSkin.label1.copyWith(color: FColorSkin.label, height: 0),
                  ),
                ),
                if (!isVietnamese)
                  FIcon(
                    icon: FOutlined.check,
                    size: 20,
                    color: FColorSkin.primary,
                  )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

void ScrollToIndex(int targetIndex, ScrollController controller, double height) {
  if (targetIndex != -1 && targetIndex > 1) {
    final itemHeight = height;

    final targetOffset = itemHeight * (targetIndex - 1);

    if (controller.position.maxScrollExtent > targetOffset) {
      controller.animateTo(targetOffset, duration: Duration(milliseconds: 400), curve: Curves.decelerate);
    } else {
      controller.animateTo(controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 400), curve: Curves.decelerate);
    }
  }
}
