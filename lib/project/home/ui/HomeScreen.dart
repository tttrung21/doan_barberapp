import 'package:doan_barberapp/components/widget/icon.dart';
import 'package:doan_barberapp/components/widget/text_button.dart';
import 'package:doan_barberapp/project/account/profile/ui/ProfileScreen.dart';
import 'package:doan_barberapp/project/home/widgets/HomeBanner.dart';
import 'package:doan_barberapp/project/home/widgets/HomeHeader.dart';
import 'package:doan_barberapp/project/home/widgets/PopularCuts.dart';
import 'package:doan_barberapp/project/home/widgets/PopularService.dart';
import 'package:doan_barberapp/shared/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/skin/color_skin.dart';
import '../../../components/skin/typo_skin.dart';
import '../../../components/style/icon_data.dart';
import '../../../generated/l10n.dart';
import '../../../shared/bloc/auth_bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, this.callbackProfile, this.callbackService});

  Function()? callbackProfile;
  Function()? callbackService;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16),
                    child: Row(
                      children: [
                        Text(
                          S.of(context).home_XinChao,
                          style: FTypoSkin.label1.copyWith(color: FColorSkin.label),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: callbackProfile,
                          child: state.profile == null ||
                                  state.profile?.profilePic == ''
                              ? CircleAvatar(
                                  radius: 20,
                                  child: Image.asset(
                                    'assets/images/placeholder_avatar.png',
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ))
                              : BuildAvatarWithUrl(state.profile!.profilePic!),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: HomeHeader(),
                  ),
                ],
              );
            },
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
            decoration: BoxDecoration(
              color: FColorSkin.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    HomeBanner(),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        S.of(context).home_KieuTocThinhHanh,
                        style: FTypoSkin.title3,
                      ),
                    ),
                    PopularCuts(),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).home_DichVuNoiBat,
                            style: FTypoSkin.title3,
                          ),
                          FTextButton(
                            textColor: FColorSkin.primary,
                            onPressed: callbackService,
                            child: Row(
                              children: [
                                Text(
                                  S.of(context).home_TimHieuThem,
                                  style: FTypoSkin.buttonText2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: FIcon(icon: FOutlined.right_arrow,size: 16,color: FColorSkin.primary),
                                )
                              ],
                            ),
                          ),
      
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    PopularService(),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
