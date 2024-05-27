import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/components/skin/color_skin.dart';
import 'package:doan_barberapp/components/skin/typo_skin.dart';
import 'package:doan_barberapp/components/widget/icon.dart';
import 'package:doan_barberapp/project/account/auth/Login.dart';
import 'package:doan_barberapp/project/account/profile/ui/PersonalProfile.dart';
import 'package:doan_barberapp/project/account/profile/ui/StaffInfo.dart';
import 'package:doan_barberapp/project/account/profile/widgets/AccountName.dart';
import 'package:doan_barberapp/project/booking/widgets/CommonDialog.dart';
import 'package:doan_barberapp/shared/bloc/auth_bloc/auth_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../components/style/icon_data.dart';
import '../../../../components/widget/bottom_sheet.dart';
import '../../../../generated/l10n.dart';
import '../../../../shared/bloc/language_cubit.dart';
import '../../../../shared/constant.dart';
import '../../../../utils/Loading.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isVietnamese = true;

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    isVietnamese = (prefs.getString('language') ?? 'vi') == 'vi';
    setState(() {});
  }

  void _onChangeLangs(BuildContext context) {
    showFMBS(
      context: context,
      height: 210,
      builder: (builder) => showLangsBTS(context, isVietnamese),
    ).then((value) async {
      if (value != null) {
        LoadingCore.loadingDialogIos(context);
        isVietnamese = value;
        await AppLocalizationDelegate()
            .load(Locale(isVietnamese ? 'vi' : 'en'));
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('language', value ? 'vi' : 'en');
        if (context.mounted) {
          context.read<LanguageCubit>().changeLanguage(value ? 'vi' : 'en');
          Navigator.of(context).pop();
        }
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(
                children: [
                  state.profile == null
                      ? CircleAvatar(
                          radius: 58,
                          child: Image.asset(
                            'assets/images/placeholder_avatar.png',
                            width: 100,
                            fit: BoxFit.cover,
                          ))
                      : StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .where('uid', isEqualTo: state.profile?.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            final data = snapshot.data?.docs[0];
                            if(data?['profilePic'] == '') {
                              return CircleAvatar(
                                  radius: 58,
                                  child: Image.asset(
                                    'assets/images/placeholder_avatar.png',
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ));
                            }
                            return Center(
                              child: SizedBox(
                                height: 115,
                                width: 115,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  fit: StackFit.expand,
                                  children: [
                                    BuildAvatarWithUrl(
                                        data?['profilePic'] ?? '',
                                        size: 80),
                                  ],
                                ),
                              ),
                            );
                          }),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('uid', isEqualTo: state.profile?.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return AccountNameSection(
                            currentName: state.profile == null
                                ? S.of(context).profile_Khach
                                : snapshot.data?.docs[0]['name']);
                      }),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).profile_ThongTinTaiKhoan,
                          style: FTypoSkin.label1
                              .copyWith(color: FColorSkin.label),
                        ),
                        const CupertinoListTileChevron()
                      ],
                    ),
                    onPressed: () {
                      if (state.profile == null) {
                        showDialog(
                          context: context,
                          builder: (context) => CommonDialog(
                            type: EnumTypeDialog.warning,
                            title: S.of(context).common_ThongBao,
                            cancelTitle: S.of(context).common_QuayLai,
                            continueTitle: S.of(context).common_DangNhap,
                            subtitle: S.of(context).common_DNTruoc,
                            onContinue: () {
                              context
                                  .read<AuthBloc>()
                                  .add(LogOutRequestedEvent());
                            },
                          ),
                        );
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PersonalProfile()));
                      }
                    },
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).profile_NgonNgu,
                            style: FTypoSkin.label1
                                .copyWith(color: FColorSkin.label),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                                isVietnamese
                                    ? S.of(context).common_TiengViet
                                    : S.of(context).common_TiengAnh,
                                style: FTypoSkin.buttonText3
                                    .copyWith(color: FColorSkin.primary)),
                            SizedBox(width: 4),
                            CupertinoListTileChevron(),
                          ],
                        )
                      ],
                    ),
                    onPressed: () => _onChangeLangs(context),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).profile_LichSuNhanVien,
                          style: FTypoSkin.label1
                              .copyWith(color: FColorSkin.label),
                        ),
                        const CupertinoListTileChevron()
                      ],
                    ),
                    onPressed: () {
                      if (state.profile == null ||
                          state.profile?.role == 'user') {
                        showDialog(
                          context: context,
                          builder: (context) => CommonDialog(
                            type: EnumTypeDialog.warning,
                            title: S.of(context).common_ThongBao,
                            cancelTitle: S.of(context).common_QuayLai,
                            continueTitle: S.of(context).common_ToiDaHieu,
                            subtitle: S.of(context).common_KhongCoQuyen,
                          ),
                        );
                      } else if (state.profile?.role == 'barber') {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StaffInfo(),
                        ));
                      }
                    },
                  ),
                  CupertinoButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LogOutRequestedEvent());
                    },
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.profile == null
                              ? S.of(context).profile_DangNhap
                              : S.of(context).profile_DangXuat,
                          style: FTypoSkin.label1
                              .copyWith(color: FColorSkin.error),
                        ),
                        FIcon(
                            icon: FOutlined.logout,
                            size: 20,
                            color: FColorSkin.error)
                      ],
                    ),
                  )
                ],
              ));
        },
        listener: (context, state) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
              (route) => false);
        },
        listenWhen: (previous, current) => current is UnauthenticatedState,
      ),
    ));
  }
}
