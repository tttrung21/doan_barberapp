import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/components/style/elevation.dart';
import 'package:doan_barberapp/components/widget/app_bar.dart';
import 'package:doan_barberapp/components/widget/filled_button.dart';
import 'package:doan_barberapp/components/widget/icon.dart';
import 'package:doan_barberapp/components/widget/text_button.dart';
import 'package:doan_barberapp/shared/models/AppointmentItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Utils/Loading.dart';
import '../../../../components/skin/color_skin.dart';
import '../../../../components/skin/typo_skin.dart';
import '../../../../components/style/icon_data.dart';
import '../../../../generated/l10n.dart';
import '../../../../shared/bloc/auth_bloc/auth_bloc.dart';
import '../../../../shared/constant.dart';
import '../../../booking/widgets/CommonDialog.dart';

class StaffHistory extends StatefulWidget {
  const StaffHistory({super.key, this.id});

  final int? id;

  @override
  State<StaffHistory> createState() => _StaffHistoryState();
}

class _StaffHistoryState extends State<StaffHistory> {
  Color getColor(int? id) {
    switch (id) {
      case 1:
        return FColorSkin.warning;
      case 2:
        return FColorSkin.error;
      case 3:
        return FColorSkin.success;
      default:
        return FColorSkin.subtitle;
    }
  }

  String getStatus(int? id) {
    switch (id) {
      case 1:
        return S.of(context).history_DangCho;
      case 2:
        return S.of(context).history_DaHuy;
      case 3:
        return S.of(context).history_HoanThanh;
      default:
        return '';
    }
  }

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
            widget.id == 0
                ? S.of(context).staffInfo_HenSapToi
                : widget.id == 1
                    ? S.of(context).staffInfo_HenChoDuyet
                    : widget.id == 2
                        ? S.of(context).staffInfo_HenDaHuy
                        : S.of(context).staffInfo_HenHoanThanh,
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
                        .where('isCancelled', isEqualTo: widget.id)
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
      padding: EdgeInsets.fromLTRB(4, 8, 0, 8),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.bookedDate} - ${item.bookedTime}',
                        style:
                            FTypoSkin.title5.copyWith(color: FColorSkin.title),
                      ),
                      if (item.isCancelled != 0)
                        Container(
                          padding: EdgeInsets.only(left: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                              color: getColor(item.isCancelled)),
                          child: Text(
                            getStatus(item.isCancelled),
                            style: FTypoSkin.subtitle3
                                .copyWith(color: FColorSkin.white),
                          ),
                        )
                    ],
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
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            item.services ?? '',
                            style: FTypoSkin.bodyText2
                                .copyWith(color: FColorSkin.subtitle),
                            softWrap: true,
                          ),
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
          ),
          if (item.isCancelled == 1 || item.isCancelled == 0)
            const SizedBox(
              height: 2,
            ),
          if (item.isCancelled == 1)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Expanded(
                      child: FFilledButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CommonDialog(
                          type: EnumTypeDialog.error,
                          title: S.of(context).history_XacNhanHuy,
                          cancelTitle: S.of(context).common_QuayLai,
                          continueTitle: S.of(context).common_XacNhan,
                          onContinue: () async {
                            LoadingCore.loadingDialogIos(context);
                            await FirebaseFirestore.instance
                                .collection('appointments')
                                .doc(item.appointmentId)
                                .update({'isCancelled' : 2});
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      );
                    },
                    backgroundColor: FColorSkin.error,
                    child: Container(
                        alignment: Alignment.center, child: Text(S.of(context).history_Huy)),
                  )),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: FFilledButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CommonDialog(
                          type: EnumTypeDialog.info,
                          title: S.of(context).history_XacNhanTiepTuc,
                          cancelTitle: S.of(context).common_QuayLai,
                          continueTitle: S.of(context).common_XacNhan,
                          onContinue: () async {
                            LoadingCore.loadingDialogIos(context);
                            await FirebaseFirestore.instance
                                .collection('appointments')
                                .doc(item.appointmentId)
                                .update({'isCancelled' : 0});
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      );
                    },
                    backgroundColor: FColorSkin.info,
                    child: Container(
                        alignment: Alignment.center, child: Text(S.of(context).history_TiepTuc)),
                  )),
                ],
              ),
            ),
          if (item.isCancelled == 0)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Expanded(
                      child: FFilledButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CommonDialog(
                              type: EnumTypeDialog.error,
                              title: S.of(context).history_XacNhanHuy,
                              cancelTitle: S.of(context).common_QuayLai,
                              continueTitle: S.of(context).common_XacNhan,
                              onContinue: () async {
                                LoadingCore.loadingDialogIos(context);
                                await FirebaseFirestore.instance
                                    .collection('appointments')
                                    .doc(item.appointmentId)
                                    .update({'isCancelled' : 2});
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          );
                        },
                        backgroundColor: FColorSkin.error,
                        child: Container(
                            alignment: Alignment.center, child: Text(S.of(context).history_Huy)),
                      )),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: FFilledButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CommonDialog(
                              type: EnumTypeDialog.info,
                              title: S.of(context).history_HoanThanh,
                              cancelTitle: S.of(context).common_QuayLai,
                              continueTitle: S.of(context).common_XacNhan,
                              onContinue: () async {
                                LoadingCore.loadingDialogIos(context);
                                await FirebaseFirestore.instance
                                    .collection('appointments')
                                    .doc(item.appointmentId)
                                    .update({'isCancelled' : 3});
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          );
                        },
                        backgroundColor: FColorSkin.info,
                        child: Container(
                            alignment: Alignment.center, child: Text(S.of(context).history_HoanThanh)),
                      )),
                ],
              ),
            ),
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
