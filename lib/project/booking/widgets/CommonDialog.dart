import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Utils/DeviceUtils.dart';
import '../../../components/skin/color_skin.dart';
import '../../../components/skin/typo_skin.dart';
import '../../../components/style/icon_data.dart';
import '../../../components/widget/icon.dart';
import '../../../generated/l10n.dart';

enum EnumTypeDialog { info, warning, success, error }

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    Key? key,
    required this.type,
    required this.title,
    this.subtitle,
    required this.cancelTitle,
    required this.continueTitle,
    this.onCancel,
    this.onContinue,
    this.customColor,
     this.service,
     this.barberName,
     this.date,
     this.timeSlot, this.fee,
  }) : super(key: key);

  final EnumTypeDialog type;
  final String title;
  final String? service;
  final String? barberName;
  final String? date;
  final String? timeSlot;
  final int? fee;
  final String? subtitle;
  final String cancelTitle;
  final String continueTitle;
  final Function()? onCancel;
  final Function()? onContinue;
  final Color? customColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: FColorSkin.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(

            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: FIcon(
                  icon: _buildType(),
                  size: 64,
                  color: customColor ?? _getTypeColor(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  title,
                  style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
                  textAlign: TextAlign.center,
                ),
              ),
              if (subtitle?.isNotEmpty ?? false)
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    subtitle ?? '',
                    style: FTypoSkin.bodyText2.copyWith(
                      color: FColorSkin.title.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (service?.isNotEmpty ?? false)
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      '${S.of(context).booking_DialogDichVu}: $service' ?? '',
                      style: FTypoSkin.bodyText2.copyWith(
                        color: FColorSkin.title.withOpacity(0.8),
                      ),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      '${S.of(context).booking_ChiPhi}: $fee' ?? '',
                      style: FTypoSkin.bodyText2.copyWith(
                        color: FColorSkin.title.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      '${S.of(context).booking_DialogBarber}: $barberName' ?? '',
                      style: FTypoSkin.bodyText2.copyWith(
                        color: FColorSkin.title.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      '${S.of(context).booking_DialogThoiGian}: $date $timeSlot' ?? '',
                      style: FTypoSkin.bodyText2.copyWith(
                        color: FColorSkin.title.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildButton(
                      cancelTitle,
                      continueTitle,
                      onCancel ?? () => Navigator.pop(context),
                      false,
                    ),
                    _buildButton(
                      cancelTitle,
                      continueTitle,
                      onContinue ?? () => Navigator.pop(context, true),
                      true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _buildType() {
    switch (type) {
      case EnumTypeDialog.error:
        return FFilled.c_remove;

      case EnumTypeDialog.success:
        return FFilled.c_check;

      case EnumTypeDialog.warning:
        return FFilled.warning_sign;

      default:
        return FFilled.c_info;
    }
  }

  Color _getTypeColor() {
    switch (type) {
      case EnumTypeDialog.error:
        return FColorSkin.error;

      case EnumTypeDialog.success:
        return FColorSkin.success;

      case EnumTypeDialog.warning:
        return FColorSkin.warning;

      default:
        return FColorSkin.info;
    }
  }

  LayoutBuilder _buildButton(
      String textFirst, String textLast, Function() onpress, bool isLast) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        /// tổng chiều dài của item nếu view lên UI
        var totalWidth = 0.0;

        /// tổng chiều dài của item khác
        var totalWidthOther = 0.0;

        var isOverflow = false;
        final deviceWidth = (MediaQuery.of(context).size.width - 48 - 32 - 16) / 2;

        totalWidth = _getTotalWidth(textFirst, totalWidth, isLast);
        totalWidthOther = _getTotalWidth(textLast, totalWidthOther, isLast);

        isOverflow = totalWidth > deviceWidth || totalWidthOther > deviceWidth;

        return CupertinoButton(
          onPressed: onpress,
          padding: EdgeInsets.zero,
          child: Container(
            constraints: BoxConstraints(minHeight: 48),
            width:
                isOverflow ? null : (MediaQuery.of(context).size.width - 48 - 32 - 16) / 2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  isLast ? (customColor ?? _getTypeColor()) : FColorSkin.grey3,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              isLast ? textLast : textFirst,
              textAlign: TextAlign.center,
              style: FTypoSkin.buttonText1.copyWith(
                color: isLast ? FColorSkin.white : FColorSkin.subtitle,
                height: 0,
              ),
            ),
          ),
        );
      },
    );
  }

  double _getTotalWidth(String text, double totalWidth, bool isLast) {
    final span = TextSpan(text: text, style: FTypoSkin.buttonText3);

    // Định nghĩa text
    final tp = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      text: span,
    );

    // ốp vào layout parent
    tp.layout();

    // 8 là padding giữa các item
    final sizeWidth = tp.width + 8 + 32;
    return totalWidth += sizeWidth;
  }
}
