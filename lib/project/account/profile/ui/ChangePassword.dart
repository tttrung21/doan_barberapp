import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/components/style/elevation.dart';
import 'package:doan_barberapp/components/widget/divider.dart';
import 'package:doan_barberapp/components/widget/form.dart';
import 'package:doan_barberapp/components/widget/text_form_field.dart';
import 'package:doan_barberapp/project/account/profile/ui/EditProfile.dart';
import 'package:doan_barberapp/utils/Validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Utils/Loading.dart';
import '../../../../components/skin/color_skin.dart';
import '../../../../components/skin/typo_skin.dart';
import '../../../../components/style/button_size.dart';
import '../../../../components/style/icon_data.dart';
import '../../../../components/style/input_size.dart';
import '../../../../components/widget/SnackBar.dart';
import '../../../../components/widget/app_bar.dart';
import '../../../../components/widget/filled_button.dart';
import '../../../../components/widget/icon.dart';
import '../../../../components/widget/text_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../shared/bloc/auth_bloc/auth_bloc.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/repository/UserRepository.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FFormState>();

  TextEditingController oldPassTEC = TextEditingController();
  TextEditingController newPassTEC = TextEditingController();
  TextEditingController reEnterPassTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
              S.of(context).profile_DoiMatKhau,
              style: FTypoSkin.title2.copyWith(
                  color: FColorSkin.primary, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        backgroundColor: FColorSkin.white,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return FForm(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _dateField(
                      title: S.of(context).profile_MatKhauHienTai,
                      hintText: S.of(context).profile_HintMatKhau,
                      controller: oldPassTEC,
                      isRequire: false,
                      isEnable: true,
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return Validate.commonCheckNull(value, context);
                        }
                        if (oldPassTEC.text.trim() != state.profile?.password) {
                          return FTextFieldStatus(
                              status: TFStatus.error,
                              message: S
                                  .of(context)
                                  .profile_KhongTrungMatKhauHienTai);
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    _dateField(
                        title: S.of(context).profile_MatKhauMoi,
                        hintText: S.of(context).profile_HintMatKhau,
                        controller: newPassTEC,
                        isRequire: false,
                        isEnable: true,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return Validate.commonCheckNull(value, context);
                          }
                          if (value == state.profile?.password) {
                            return FTextFieldStatus(
                                status: TFStatus.error,
                                message:
                                    S.of(context).profile_TrungMatKhauHienTai);
                          }
                          if(value!.length < 8) {
                            return Validate.lengthValidate(value, context, [8]);
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 8,
                    ),
                    _dateField(
                        title: S.of(context).profile_NhapLaiMatKhau,
                        hintText: S.of(context).profile_NhapLaiMatKhau,
                        controller: reEnterPassTEC,
                        isRequire: false,
                        isEnable: true,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return Validate.commonCheckNull(value, context);
                          }
                          if (value != newPassTEC.text) {
                            return FTextFieldStatus(
                                status: TFStatus.error,
                                message:
                                    S.of(context).profile_MatKhauKhongKhop);
                          }
                          return null;
                        }),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return FFilledButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();

                        if (_formKey.currentState!.validate()) {
                          try {
                            LoadingCore.loadingDialogIos(context);
                            await FirebaseAuth.instance.currentUser
                                ?.updatePassword(newPassTEC.text)
                                .then((value) {
                              CollectionReference userRef = FirebaseFirestore.instance.collection('users');
                              userRef.doc(state.profile?.uid).update({'password' : newPassTEC.text});
                            });
                            state.profile = await UserRepository().fetchUser();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              SnackBarCore.success(
                                  title: S.of(context).common_ThanhCong);
                            }
                          } on FirebaseException catch (e) {
                            SnackBarCore.fail(title: e.message ?? e.code);
                          }
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      size: FButtonSize.size48,
                      backgroundColor: FColorSkin.primary,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).profile_CapNhatThongTin,
                            style: FTypoSkin.buttonText1
                                .copyWith(color: FColorSkin.white),
                          )),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _dateField({
    required String title,
    required String hintText,
    required controller,
    required bool isRequire,
    required isEnable,
    void Function()? onTap,
    bool isSuffixIcon = false,
    bool isDatePicker = false,
    bool isBigTextArea = false,
    void Function(String)? onChanged,
    FFormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: FTypoSkin.label3.copyWith(color: FColorSkin.title),
            children: [
              TextSpan(
                text: isRequire ? '*' : '',
                style: FTypoSkin.label3.copyWith(color: FColorSkin.error),
              )
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        FTextFormField(
          controller: controller,
          obscureText: true,
          size: isBigTextArea ? FInputSize.size256 : FInputSize.size40,
          hintText: hintText,
          hintStyle: isBigTextArea == false
              ? FTypoSkin.bodyText2.copyWith(
                  color: FColorSkin.title.withOpacity(0.4),
                )
              : FTypoSkin.label2.copyWith(
                  color: FColorSkin.title.withOpacity(0.4),
                ),
          suffixIcon: isSuffixIcon
              ? isDatePicker
                  ? FIcon(
                      icon: FFilled.calendar_date,
                      size: 16,
                      color: FColorSkin.subtitle)
                  : FIcon(
                      icon: FFilled.arrow_down,
                      size: 16,
                      color: FColorSkin.subtitle)
              : null,
          readOnly: onTap != null ? true : false,
          onTap: onTap,
          enabled: isEnable,
          backgroundColor: isEnable ? null : FColorSkin.disable,
          maxLine: isBigTextArea ? 3 : 1,
          maxLength: 500,
          onChanged: onChanged,
          validator: validator,
        )
      ],
    );
  }
}
