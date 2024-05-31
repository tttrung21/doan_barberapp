import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/skin/color_skin.dart';
import '../../../components/skin/typo_skin.dart';
import '../../../components/style/button_size.dart';
import '../../../components/style/icon_data.dart';
import '../../../components/widget/app_bar.dart';
import '../../../components/widget/filled_button.dart';
import '../../../components/widget/icon.dart';
import '../../../generated/l10n.dart';
import '../../../shared/constant.dart';
import '../../../shared/models/FilterItem.dart';

class FilterHistory extends StatefulWidget {
  const FilterHistory({super.key, this.filterItem, this.listBarber});

  final FilterItem? filterItem;
  final List<QueryDocumentSnapshot>? listBarber;

  @override
  State<FilterHistory> createState() => _FilterHistoryState();
}

class _FilterHistoryState extends State<FilterHistory> {
  List<QueryDocumentSnapshot>? listBarber;
  String? barber;
  int? isCancelled;
  Map<int,String> mapIsCancelled =
    {
      0 : "Đã đặt",
      1 : "Đang chờ hủy",
      2 : "Đã hủy",
      3 : "Đã hoàn thành"
    };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listBarber = widget.listBarber ?? [];
    barber = widget.filterItem?.barberId;
    isCancelled = widget.filterItem?.isCancelled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FColorSkin.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(64),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 4),
                    child: Container(
                      height: 4,
                      width: 32,
                      decoration: BoxDecoration(
                        color: Color(0xffEAEAEA),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                FAppBar(
                  title: Text(
                    S.of(context).common_BoLoc,
                    style: FTypoSkin.title2
                        .copyWith(color: FColorSkin.title, height: 0),
                  ),
                  centerTitle: true,
                  leading: FFilledButton.icon(
                    size: FButtonSize.size32,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: FColorSkin.transparent,
                    child: FIcon(
                      icon: FOutlined.e_remove,
                      color: FColorSkin.subtitle,
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                )
              ],
            )),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).history_ChonBarber,
                      style: FTypoSkin.title3,
                    ),
                    SizedBox(height: 8,),
                    listBarber!.isEmpty
                        ? BuildEmptyData(
                            title: S.of(context).booking_KhongCoBarber)
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              final itemWidth = (constraints.maxWidth - 12) / 2;
                              return Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                alignment: WrapAlignment.start,
                                children: [
                                  for (int i = 0; i < listBarber!.length; i++)
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        barber = listBarber?[i]['uid'];
                                        setState(() {

                                        });
                                      },
                                      child: Container(
                                        width: itemWidth,
                                        padding: EdgeInsets.symmetric(vertical: 9,horizontal: 16),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: barber == listBarber?[i]['uid']
                                              ? FColorSkin.primaryBackground
                                              : FColorSkin.grey2,
                                        ),
                                        child: Text(
                                          listBarber?[i]['name'],
                                          style: FTypoSkin.buttonText3.copyWith(
                                              color: barber ==
                                                      listBarber?[i]['uid']
                                                  ? Color(0xff705DCF)
                                                  : FColorSkin.subtitle),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                ],
                              );
                            },
                          ),
                    SizedBox(height: 16,),
                    Text(
                      S.of(context).history_TrangThai,
                      style: FTypoSkin.title3,
                    ),
                    SizedBox(height: 8,),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final itemWidth = (constraints.maxWidth - 12) / 2;
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.start,
                          children: [
                            for (int i = 0; i < mapIsCancelled.length; i++)
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  isCancelled = mapIsCancelled.keys.elementAt(i);
                                  setState(() {});
                                },
                                child: Container(
                                  width: itemWidth,
                                  padding: EdgeInsets.symmetric(vertical: 9,horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: isCancelled == mapIsCancelled.keys.elementAt(i)
                                        ? FColorSkin.primaryBackground
                                        : FColorSkin.grey2,
                                  ),
                                  child: Text(
                                    mapIsCancelled[i]!,
                                    style: FTypoSkin.buttonText3.copyWith(
                                        color: isCancelled == mapIsCancelled.keys.elementAt(i)
                                            ? Color(0xff705DCF)
                                            : FColorSkin.subtitle),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(
              16, 8, 16, MediaQuery.of(context).padding.bottom + 8),
          child: Row(children: [
            Expanded(
              child: FFilledButton(
                backgroundColor: FColorSkin.grey3,
                onPressed: () {
                  Navigator.of(context).pop(FilterItem().nullItem());
                },
                size: FButtonSize.size48,
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).common_ThietLapLai,
                      style: FTypoSkin.buttonText1
                          .copyWith(color: FColorSkin.subtitle, height: 0),
                    )),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: FFilledButton(
                backgroundColor: FColorSkin.primary,
                onPressed: () {
                  Navigator.of(context).pop(FilterItem(barberId: barber,isCancelled: isCancelled));
                },
                size: FButtonSize.size48,
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).common_ApDung,
                      style: FTypoSkin.buttonText1.copyWith(height: 0),
                    )),
              ),
            ),
          ]),
        ));
  }
}
