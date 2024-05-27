import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/components/style/elevation.dart';
import 'package:doan_barberapp/components/widget/app_bar.dart';
import 'package:doan_barberapp/components/widget/icon.dart';
import 'package:doan_barberapp/components/widget/text_button.dart';
import 'package:doan_barberapp/shared/models/AppointmentItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/skin/color_skin.dart';
import '../../../../components/skin/typo_skin.dart';
import '../../../../components/style/icon_data.dart';
import '../../../../generated/l10n.dart';
import '../../../../shared/bloc/auth_bloc/auth_bloc.dart';
import '../../../../shared/constant.dart';

class StaffHistory extends StatefulWidget {
  const StaffHistory({super.key});

  @override
  State<StaffHistory> createState() => _StaffHistoryState();
}

class _StaffHistoryState extends State<StaffHistory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            S.of(context).profile_LichSuNhanVien,
            style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
          ),
        ),
      ),
      backgroundColor: FColorSkin.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('appointments')
                        .where('barberId', isEqualTo: state.profile?.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return buildLoading();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(S.of(context).common_LoiXayRa),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.docs.isEmpty) {
                        return BuildEmptyData(
                            title: S.of(context).common_DuLieuTrong);
                      }
                      final appointmentDocs = snapshot.data?.docs;
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shrinkWrap: true,
                        itemCount: appointmentDocs?.length ?? 0,
                        itemBuilder: (context, index) {
                          return appointmentCard(AppointmentItem.fromDocument(
                              appointmentDocs?[index] as DocumentSnapshot));
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                      );
                    }),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget appointmentCard(AppointmentItem item) {
    return Container(
      padding: EdgeInsets.fromLTRB(4, 8, 8, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: FColorSkin.white,
          boxShadow: FElevation.elevation),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/HistoryBooking.jpg',
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.bookedDate} - ${item.bookedTime}',
                    style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: FIcon(
                          icon: FOutlined.scissors,
                          size: 16,
                          color: FColorSkin.subtitle,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          item.services ?? '',
                          style: FTypoSkin.bodyText2
                              .copyWith(color: FColorSkin.subtitle),
                          softWrap: true,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: FIcon(
                          icon: FFilled.person_edit,
                          size: 16,
                          color: FColorSkin.subtitle,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          item.barberName ?? '',
                          style: FTypoSkin.bodyText2
                              .copyWith(color: FColorSkin.subtitle),
                          softWrap: true,
                        ),
                      )
                    ],
                  )
                ],
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget buildLoading() {
    return BuildShimmer(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
            0, 16, 0, 0 + MediaQuery.of(context).padding.bottom),
        child: Column(
          children: [
            ...List.generate(
              10,
              (index) => Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                height: 182,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: FColorSkin.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
