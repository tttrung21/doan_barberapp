import 'dart:io';

import 'package:doan_barberapp/components/widget/app_bar.dart';
import 'package:doan_barberapp/shared/models/UserModel.dart';
import 'package:doan_barberapp/shared/repository/UserRepository.dart';
import 'package:doan_barberapp/utils/Loading.dart';
import 'package:doan_barberapp/utils/Validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../components/skin/color_skin.dart';
import '../../../../components/skin/typo_skin.dart';
import '../../../../components/style/button_size.dart';
import '../../../../components/style/icon_data.dart';
import '../../../../components/style/input_size.dart';
import '../../../../components/widget/FDatePicker.dart';
import '../../../../components/widget/SnackBar.dart';
import '../../../../components/widget/bottom_sheet.dart';
import '../../../../components/widget/filled_button.dart';
import '../../../../components/widget/form.dart';
import '../../../../components/widget/icon.dart';
import '../../../../components/widget/text_button.dart';
import '../../../../components/widget/text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../../../shared/bloc/auth_bloc/auth_bloc.dart';
import '../../../../shared/constant.dart';
import '../../../../utils/ConvertUtils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, this.user});

  final UserModel? user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FFormState>();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController dobTEC = TextEditingController();
  bool _hasInteracted = false;
  final auth = FirebaseAuth.instance.currentUser;
  UserModel? user;
  DateTime now = DateTime.now();
  File? img;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    if (user != null) {
      nameTEC.text = user?.name ?? '';
      phoneTEC.text = user?.phoneNumber ?? '';
      emailTEC.text = user?.email ?? auth?.email ?? '';
      dobTEC.text = user?.dob ?? '';
    }
  }

  bool checkUpdateData() {
    if (nameTEC.text != user?.name) {
      return true;
    }
    if (phoneTEC.text != user?.phoneNumber) {
      return true;
    }
    if (dobTEC.text != user?.dob) {
      return true;
    }
    if (img != null) {
      return true;
    }
    return false;
  }

  Future<File?> pickImage() async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      SnackBarCore.fail(title: 'Error picking image');
    }
    return image;
  }

  void selectImage() async {
    img = await pickImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: FAppBar(
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
              S.of(context).profile_CapNhatThongTin,
              style: FTypoSkin.title2.copyWith(
                  color: FColorSkin.primary, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        backgroundColor: FColorSkin.white,
        body: FForm(
          autovalidateMode: _hasInteracted
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Stack(
                children: [
                  Image.asset('assets/images/barber_bg.jpg'),
                  Positioned(
                    top: 25,
                    left: MediaQuery.of(context).size.width / 2 - 32,
                    child: InkWell(
                      onTap: selectImage,
                      child: Stack(
                        children: [
                          img != null
                              ? CircleAvatar(
                                  radius: 40,
                                  backgroundImage: FileImage(img!),
                                )
                              : user?.profilePic != ''
                                  ? BuildAvatarWithUrl(user!.profilePic!,
                                      size: 80)
                                  : CircleAvatar(
                                      radius: 40,
                                      child: Image.asset(
                                        'assets/images/placeholder_avatar.png',
                                        width: 60,
                                        fit: BoxFit.cover,
                                      )),
                          Positioned(
                            bottom: 0,
                            right: -1,
                            child: FIcon(icon: FOutlined.camera),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _dateField(
                            title: S.of(context).profile_HoTen,
                            hintText: S.of(context).profile_HintHoTen,
                            controller: nameTEC,
                            isRequire: false,
                            isEnable: true,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _dateField(
                            title: S.of(context).profile_SDT,
                            hintText: S.of(context).profile_HintSDT,
                            controller: phoneTEC,
                            isRequire: false,
                            isEnable: true,
                            numbersOnly: true,
                            validator:(value) {
                              if(value?.isNotEmpty ?? false) {
                                return Validate.phoneValidate(value, context);
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _dateField(
                            title: S.of(context).profile_Email,
                            hintText: S.of(context).profile_Email,
                            controller: emailTEC,
                            isRequire: false,
                            isEnable: false),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _dateField(
                            title: S.of(context).profile_NgaySinh,
                            hintText: S.of(context).profile_HintNgaySinh,
                            controller: dobTEC,
                            isRequire: false,
                            isEnable: true,
                            onTap: () async {
                              await showFMBS(
                                  context: context,
                                  builder: (context) => FDatePicker(
                                      S.of(context).profile_HintNgaySinh,
                                      buttonTitle: S.of(context).common_Chon,
                                      controller: dobTEC,
                                      maximumDate: now.copyWith(
                                          hour: 0,
                                          minute: 0,
                                          second: 0,
                                          millisecond: 0,
                                          microsecond: 0),
                                      maximumYear: now.year,
                                      initDateTime: dobTEC.text.isEmpty
                                          ? now.copyWith(
                                              hour: 0,
                                              minute: 0,
                                              second: 0,
                                              millisecond: 0,
                                              microsecond: 0)
                                          : DateTime.parse(FDate.yMd(dobTEC.text
                                              .replaceAll('/', '-'))))).then(
                                  (value) {
                                if (value is DateTime) {
                                  dobTEC.text = FDate.dMy(value);
                                }
                                setState(() {});
                              });
                            },
                            isSuffixIcon: true,
                            isDatePicker: true),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return FFilledButton(
                      onPressed: !checkUpdateData()
                          ? null
                          : () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (!_hasInteracted) {
                                setState(() {
                                  _hasInteracted = true;
                                });
                              }
                              if (_formKey.currentState!.validate()) {
                                try {
                                  LoadingCore.loadingDialogIos(context);
                                  final userRepository = UserRepository();
                                  await userRepository.saveUserData(
                                      userModel: UserModel(
                                          uid: user?.uid,
                                          dob: dobTEC.text ?? user?.dob,
                                          name: nameTEC.text ?? user?.name,
                                          profilePic: user?.profilePic,
                                          phoneNumber: phoneTEC.text ?? user?.phoneNumber,
                                          role: user?.role,
                                          password: user?.password,
                                          email: user?.email),
                                      file: img);
                                  state.profile =
                                      await userRepository.fetchUser();
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                    SnackBarCore.success(
                                        title:
                                        S.of(context).common_ThanhCong);
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
                      backgroundColor: !checkUpdateData()
                          ? FColorSkin.grey3
                          : FColorSkin.primary,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).profile_CapNhatThongTin,
                            style: FTypoSkin.buttonText1.copyWith(
                                color: !checkUpdateData()
                                    ? FColorSkin.subtitle
                                    : FColorSkin.white),
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
    bool numbersOnly = false,
    void Function(String)? onChanged,
    FFormFieldValidator<String>? validator,
  }) {
    List<TextInputFormatter>? inputFormatters;
    if (numbersOnly) {
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    }
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
        const SizedBox(
          height: 8,
        ),
        FTextFormField(
          inputFormatters: inputFormatters,
          controller: controller,
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
                      icon: FOutlined.down_arrow,
                      size: 16,
                      color: FColorSkin.subtitle,
                    )
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
