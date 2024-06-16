import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/Utils/Loading.dart';
import 'package:doan_barberapp/components/style/elevation.dart';
import 'package:doan_barberapp/components/widget/bottom_sheet.dart';
import 'package:doan_barberapp/components/widget/icon.dart';
import 'package:doan_barberapp/components/widget/text_button.dart';
import 'package:doan_barberapp/project/booking/ui/BookingScreen.dart';
import 'package:doan_barberapp/project/booking/widgets/CommonDialog.dart';
import 'package:doan_barberapp/project/history/Widgets/BTSOption.dart';
import 'package:doan_barberapp/project/history/Widgets/Filter.dart';
import 'package:doan_barberapp/shared/bloc/auth_bloc/auth_bloc.dart';
import 'package:doan_barberapp/shared/models/AppointmentItem.dart';
import 'package:doan_barberapp/shared/models/FilterItem.dart';
import 'package:doan_barberapp/shared/repository/DataRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/skin/color_skin.dart';
import '../../../components/skin/typo_skin.dart';
import '../../../components/style/button_size.dart';
import '../../../components/style/icon_data.dart';
import '../../../components/widget/divider.dart';
import '../../../generated/l10n.dart';
import '../../../shared/constant.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int? id;
  String? barberId;
  bool isFiltered = false;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 48,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  S.of(context).history_LichSuCat,
                  style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
                ),
              ),
              FTextButton(
                  child: FIcon(
                    icon: isFiltered ? FFilled.filter_active : FFilled.filter,
                    size: 20,
                  ),
                  onPressed: () async {
                    LoadingCore.loadingDialogIos(context);
                    final docs = await DataRepository().getBarbers();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                    if (context.mounted) {
                      FilterItem filter = FilterItem(isCancelled: id,barberId: barberId);
                      final res = await showFMBS(
                        isDismissible: false,
                        height: MediaQuery.of(context).size.height * 480 / 896,
                        context: context,
                        builder: (context) => FilterHistory(
                          filterItem: filter,
                          listBarber: docs,
                        ),
                      );
                      if(res is FilterItem){
                        barberId = res.barberId;
                        id = res.isCancelled;
                        if(barberId != null || id != null){
                          isFiltered = true;
                        }
                        else{
                          isFiltered = false;
                        }
                      }
                      setState(() {});
                    }
                  })
            ],
          ),
          FDivider(
            height: 0,
            color: FColorSkin.border2,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.profile == null
                  ? Center(
                      child: Text(S.of(context).history_DangNhapTruoc),
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('appointments')
                                .where('userId', isEqualTo: state.profile?.uid)
                                .where('isCancelled', isEqualTo: id)
                                .where('barberId', isEqualTo: barberId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return buildLoading();
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(S.of(context).common_LoiXayRa),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data == null ||
                                  snapshot.data!.docs.isEmpty) {
                                return BuildEmptyData(
                                    title: S.of(context).history_LichSuTrong);
                              }
                              final userDocs = snapshot.data?.docs;
                              return ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                shrinkWrap: true,
                                itemCount: userDocs?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return appointmentCard(
                                      AppointmentItem.fromDocument(
                                          userDocs?[index]
                                              as DocumentSnapshot));
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 16,
                                ),
                              );
                            }),
                      ],
                    );
            },
          ),
        ],
      ),
    ));
  }

  Widget appointmentCard(AppointmentItem item) {
    return Container(
      padding: EdgeInsets.fromLTRB(4, 8, 8, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: FColorSkin.white,
          boxShadow: FElevation.elevation),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${item.bookedDate} - ${item.bookedTime}',
                  style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
                ),
                if (item.isCancelled != 3 && item.isCancelled != 2)
                  FTextButton(
                    onPressed: () async {
                      await showFMBS(
                        height: 250 / 896 * MediaQuery.of(context).size.height,
                        context: context,
                        builder: (context) => BTSOption(
                          id: item.isCancelled,
                        ),
                      ).then((value) async {
                        if (value == Option.cancel) {
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
                                    .update({'isCancelled': 1});
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          );
                        }
                        if (value == Option.resume) {
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
                                    .update({'isCancelled': 0});
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          );
                        }
                        if (value == Option.edit){
                          LoadingCore.loadingDialogIos(context);
                          final docs = await DataRepository().getBarbers();
                          if (mounted) {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BookingScreen(
                                  listBarber: docs,
                                  isEdit: true,
                                  appointmentItem: item,
                                )));
                          }
                        }
                      });
                    },
                    size: FButtonSize.size24,
                    child: FIcon(icon: FFilled.more_vertical),
                  )
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
                  child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                    SizedBox(
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
                    ),
                    if (item.isCancelled != 0)
                      SizedBox(
                        height: 8,
                      ),
                    if (item.isCancelled != 0)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: FIcon(
                              icon: FFilled.c_info,
                              size: 16,
                              color: FColorSkin.subtitle,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              getStatus(item.isCancelled) ?? '',
                              style: FTypoSkin.bodyText2
                                  .copyWith(color: getColor(item.isCancelled)),
                              softWrap: true,
                            ),
                          )
                        ],
                      )
                  ],
                ),
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
