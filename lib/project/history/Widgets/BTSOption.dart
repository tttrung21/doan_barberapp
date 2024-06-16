import 'package:flutter/cupertino.dart';

import '../../../components/skin/color_skin.dart';
import '../../../components/skin/typo_skin.dart';
import '../../../components/style/button_size.dart';
import '../../../components/style/icon_data.dart';
import '../../../components/widget/app_bar.dart';
import '../../../components/widget/filled_button.dart';
import '../../../components/widget/icon.dart';
import '../../../generated/l10n.dart';

enum Option { cancel, resume, edit }

class BTSOption extends StatelessWidget {
  const BTSOption({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FColorSkin.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 4),
              child: Container(
                height: 4,
                width: 32,
                decoration: BoxDecoration(
                  color: Color(0xffEAEAEA),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          FAppBar(
            title: Text(
              S.of(context).common_Chon,
              style:
                  FTypoSkin.title2.copyWith(color: FColorSkin.title, height: 0),
            ),
            centerTitle: true,
            leading: FFilledButton.icon(
              size: FButtonSize.size32,
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
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (id == 0)
                  CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).pop(Option.cancel);
                    },
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: FColorSkin.primaryBackground,
                            shape: BoxShape.circle,
                          ),
                          child: FIcon(
                              size: 20,
                              icon: FOutlined.trash_can,
                              color: FColorSkin.primary),
                        ),
                        SizedBox(width: 12),
                        Text(
                          S.of(context).history_Huy,
                          style: FTypoSkin.title6
                              .copyWith(color: FColorSkin.label),
                        )
                      ],
                    ),
                  ),
                if (id == 0) const SizedBox(height: 16),
                if (id == 1)
                  CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).pop(Option.resume);
                    },
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: FColorSkin.primaryBackground,
                            shape: BoxShape.circle,
                          ),
                          child: FIcon(
                              size: 20,
                              icon: FOutlined.restore,
                              color: FColorSkin.primary),
                        ),
                        SizedBox(width: 12),
                        Text(
                          S.of(context).history_TiepTuc,
                          style: FTypoSkin.title6
                              .copyWith(color: FColorSkin.label),
                        )
                      ],
                    ),
                  ),
                if( id != 1)
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop(Option.edit);
                  },
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: FColorSkin.primaryBackground,
                          shape: BoxShape.circle,
                        ),
                        child: FIcon(
                            size: 20,
                            icon: FOutlined.e_edit,
                            color: FColorSkin.primary),
                      ),
                      SizedBox(width: 12),
                      Text(
                        S.of(context).history_ChinhSua,
                        style: FTypoSkin.title6
                            .copyWith(color: FColorSkin.label),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
