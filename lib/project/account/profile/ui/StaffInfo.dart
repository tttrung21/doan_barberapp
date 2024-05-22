import 'package:doan_barberapp/project/account/profile/ui/StaffHistory.dart';
import 'package:doan_barberapp/project/account/profile/widgets/Chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../components/skin/color_skin.dart';
import '../../../../components/skin/typo_skin.dart';
import '../../../../components/style/icon_data.dart';
import '../../../../components/widget/app_bar.dart';
import '../../../../components/widget/icon.dart';
import '../../../../components/widget/text_button.dart';
import '../../../../generated/l10n.dart';

class StaffInfo extends StatelessWidget {
  const StaffInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar(
        backgroundColor: FColorSkin.white,
        leading: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: FTextButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: FIcon(
              icon: FOutlined.left_arrow,
              color: FColorSkin.primary,
              size: 20,
            ),
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            S.of(context).profile_ThongTinTaiKhoan,
            style: FTypoSkin.title2.copyWith(
                color: FColorSkin.primary, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      backgroundColor: FColorSkin.white,
      body: Column(
            children: [
              CupertinoButton(
                padding: EdgeInsets.all(16),
                color: FColorSkin.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).profile_DoanhThu,
                      style: FTypoSkin.label1
                          .copyWith(color: FColorSkin.primary),
                    ),
                    const CupertinoListTileChevron()
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chart(),));
                },
              ),
              SizedBox(height: 12,),
              CupertinoButton(
                padding: EdgeInsets.all(16),
                color: FColorSkin.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).profile_LichSuNhanVien,
                      style: FTypoSkin.label1
                          .copyWith(color: FColorSkin.primary),
                    ),
                    const CupertinoListTileChevron()
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => StaffHistory(),));
                },
              ),
            ],
          )
    );
  }
}
