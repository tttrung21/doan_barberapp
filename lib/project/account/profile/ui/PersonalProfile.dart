import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/components/style/elevation.dart';
import 'package:doan_barberapp/components/widget/divider.dart';
import 'package:doan_barberapp/project/account/profile/ui/ChangePassword.dart';
import 'package:doan_barberapp/project/account/profile/ui/EditProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/skin/color_skin.dart';
import '../../../../components/skin/typo_skin.dart';
import '../../../../components/style/icon_data.dart';
import '../../../../components/widget/app_bar.dart';
import '../../../../components/widget/icon.dart';
import '../../../../components/widget/text_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../shared/bloc/auth_bloc/auth_bloc.dart';
import '../../../../shared/constant.dart';

class PersonalProfile extends StatelessWidget {
  const PersonalProfile({super.key});

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
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).profile_ThongTinCaNhan,
                      style: FTypoSkin.label3.copyWith(
                          color: FColorSkin.primary),
                    ),
                    FTextButton(
                        child: Text(
                          S.of(context).profile_ChinhSua,
                          style: FTypoSkin.title4
                              .copyWith(color: FColorSkin.primary.withOpacity(
                              0.9)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfile(user: state.profile,),
                              ));
                        })
                  ],
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isEqualTo: state.profile?.uid)
                    .snapshots(),
                builder: (context, snapshot)
                {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(),);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(S.of(context).common_LoiXayRa),
                    );
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.docs.isEmpty) {
                    return BuildEmptyData(title: S.of(context).common_DuLieuTrong);
                  }
                  final userDocs = snapshot.data?.docs[0];
                  return Container(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    decoration: BoxDecoration(
                        boxShadow: FElevation.elevation,
                        color: FColorSkin.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${S.of(context).profile_HoTen}:',
                              style: FTypoSkin.subtitle2
                                  .copyWith(color: FColorSkin.subtitle),
                            ),
                            Expanded(
                                child: Text(userDocs?['name'] ?? '',
                                    style: FTypoSkin.title4
                                        .copyWith(color: FColorSkin.title),
                                    textAlign: TextAlign.right))
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: FDivider(color: FColorSkin.grey2,),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${S.of(context).profile_Email}:',
                              style: FTypoSkin.subtitle2
                                  .copyWith(color: FColorSkin.subtitle),
                            ),
                            Expanded(
                                child: Text(userDocs?['email'] ?? '',
                                    style: FTypoSkin.title4
                                        .copyWith(color: FColorSkin.title),
                                    textAlign: TextAlign.right))
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: FDivider(color: FColorSkin.grey2,),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${S.of(context).profile_SDT}:',
                              style: FTypoSkin.subtitle2
                                  .copyWith(color: FColorSkin.subtitle),
                            ),
                            Expanded(
                                child: Text(userDocs?['phoneNumber'] ?? '',
                                    style: FTypoSkin.title4
                                        .copyWith(color: FColorSkin.title),
                                    textAlign: TextAlign.right))
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: FDivider(color: FColorSkin.grey2,),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${S.of(context).profile_VaiTro}:',
                              style: FTypoSkin.subtitle2
                                  .copyWith(color: FColorSkin.subtitle),
                            ),
                            Expanded(
                                child: Text(
                                  userDocs?['role'] ?? '',
                              style: FTypoSkin.title4
                                  .copyWith(color: FColorSkin.title),
                              textAlign: TextAlign.right,
                            ))
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12,),
              CupertinoButton(
                padding: const EdgeInsets.all(16),
                color: FColorSkin.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).profile_DoiMatKhau,
                      style: FTypoSkin.label1
                          .copyWith(color: FColorSkin.primary),
                    ),
                    const CupertinoListTileChevron()
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePassword(),));
                },
              ),

            ],
          );
        },
      ),
    );
  }
}
