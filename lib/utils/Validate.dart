
import 'package:flutter/material.dart';

import '../components/widget/form.dart';
import '../generated/l10n.dart';

class Validate {
  // static FTextFieldStatus phoneValidate(String? value, BuildContext context) {
  //   final regex = RegExp(r'^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$');
  //   if (value!.trim().isEmpty) {
  //     return FTextFieldStatus(status: TFStatus.error, message: S.of(context).common_ThieuThongTin);
  //   } else {
  //     if (!regex.hasMatch(value)) {
  //       return FTextFieldStatus(status: TFStatus.error, message: S.of(context).common_SDTGom10KyTu);
  //     }
  //
  //     return FTextFieldStatus(status: TFStatus.normal, message: null);
  //   }
  // }

  static FTextFieldStatus emailValidate(String? value, BuildContext context) {
    final regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\")){2,}@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!regex.hasMatch(value!)) {
      if (value.trim().isEmpty) {
        return FTextFieldStatus(status: TFStatus.error, message: S.of(context).common_ThieuThongTin);
      }
      return FTextFieldStatus(status: TFStatus.error, message: S.of(context).common_EmailKhongHopLe);
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
  }

  // static FTextFieldStatus identityCardValidate(String? value, BuildContext context) {
  //   const patttern = r'([0-9]$)';
  //   final regex = RegExp(patttern);
  //   if (!regex.hasMatch(value!)) {
  //     return FTextFieldStatus(status: TFStatus.error, message: S.of(context).common_CMNDKhongDungDinhDang);
  //   }
  //   if (value.length != 9 && value.length != 12) {
  //     if (value.trim().isEmpty) {
  //       return FTextFieldStatus(status: TFStatus.error, message: S.of(context).common_ThieuThongTin);
  //     }
  //     return FTextFieldStatus(status: TFStatus.error, message: S.of(context).common_VuiLongNhapDung9Hoac12So);
  //   } else {
  //     return FTextFieldStatus(status: TFStatus.normal, message: null);
  //   }
  // }

  static FTextFieldStatus commonCheckNull(String? value, BuildContext context) {
    if (value?.trim().isEmpty ?? true) {
      return FTextFieldStatus(status: TFStatus.error, message: S.of(context).common_ThieuThongTin);
    } else {
      return FTextFieldStatus(status: TFStatus.normal, message: null);
    }
  }

  static FTextFieldStatus lengthValidate(String? value, BuildContext context, List<int> length) {
    if (!length.contains(value!.trim().length)) {
      if (value.trim().isEmpty) {
        return FTextFieldStatus(
          status: TFStatus.normal,
          message: null,
        );
      }
      return FTextFieldStatus(
        status: TFStatus.error,
        message: S.of(context).common_LoiMK8KyTu,
      );
    } else {
      return FTextFieldStatus(
        status: TFStatus.normal,
        message: null,
      );
    }
  }
}
