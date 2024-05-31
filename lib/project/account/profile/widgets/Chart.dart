import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:doan_barberapp/Utils/Loading.dart';
import 'package:doan_barberapp/components/style/color.dart';
import 'package:doan_barberapp/components/style/elevation.dart';
import 'package:doan_barberapp/components/widget/app_bar.dart';
import 'package:doan_barberapp/utils/ConvertUtils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../components/skin/color_skin.dart';
import '../../../../components/skin/typo_skin.dart';
import '../../../../components/style/icon_data.dart';
import '../../../../components/style/input_size.dart';
import '../../../../components/widget/FDatePicker.dart';
import '../../../../components/widget/bottom_sheet.dart';
import '../../../../components/widget/form.dart';
import '../../../../components/widget/icon.dart';
import '../../../../components/widget/text_button.dart';
import '../../../../components/widget/text_form_field.dart';
import '../../../../generated/l10n.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<ChartData> chartData = [
    ChartData(1, 100000),
    ChartData(2, 120000),
    ChartData(3, 110000),
    ChartData(4, 350000),
    ChartData(5, 200000),
    ChartData(6, 150000),
    ChartData(7, 320000),
    ChartData(8, 330000),
    ChartData( 9, 300000),
    ChartData(10, 170000),
    ChartData(11, 100000),
    ChartData(12, 410000),
    ChartData(13, 230000),
    ChartData(14, 270000),
    ChartData(15, 110000),
    ChartData(16, 155000),
  ];
  late ZoomPanBehavior _zoomPanBehavior;
  int pageIndex = 0; 
  
  ///monthly
  DateTime temp = DateTime.now();
  
  ///daily
  DateTime now = DateTime.now();
  num? fee;
  int? apps;

  TextEditingController dailyTEC = TextEditingController();
  TextEditingController monthlyTEC = TextEditingController();
  final _auth = FirebaseAuth.instance.currentUser;

  Future<void> showFDatePicker(
      TextEditingController controller, String title) async {
    await showFMBS(
            context: context,
            builder: (context) => FDatePicker(title,
                buttonTitle: S.of(context).common_Chon,
                controller: controller,
                initDateTime: now
                // controller.text.isEmpty
                //     ? now
                //     : DateTime.parse(
                //         FDate.yMd(controller.text.replaceAll('/', '-')))
            )
    )
        .then((value) async {
      if (value is DateTime) {
        now = value;
        controller.text = await value.formattedDate();
        await fetchDailyData(value.day,value.month, value.year);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      // enablePinching: true,
      // zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    super.initState();
  }
  Future<void> fetchMonthlyData(DateTime selectedDate) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('barberId', isEqualTo: _auth?.uid)
          .where('isCancelled',isEqualTo: 3)
          .get();

      if (snapshot.docs.isNotEmpty) {
        Map<int, num> dailyFees = {};
        for (var doc in snapshot.docs) {
          String dateStr = doc['bookedDate'];
          num fee = doc['estimatedFee'];
          DateTime date = DateFormat('dd/MM/yyyy').parse(dateStr);

          if (date.month == selectedDate.month && date.year == selectedDate.year) {
            if (dailyFees.containsKey(date.day)) {
              dailyFees[date.day] = dailyFees[date.day]! + fee;
            } else {
              dailyFees[date.day] = fee;
            }
          }
        }

        setState(() {
          chartData = List.generate(selectedDate.lastDayOfMonth().day, (index) {
            int day = index + 1;
            return ChartData(day, dailyFees[day] ?? 0);
          });
        });
      }
    } catch (e) {
      print('Error fetching appointments data: $e');
    }
  }
  Future fetchDailyData(int day,int month, int year) async {
    fee = 0;
    apps = 0;
    final data = await FirebaseFirestore.instance
        .collection('appointments')
        .where('barberId', isEqualTo: _auth?.uid)
        .where('isCancelled',isEqualTo: 3)
        .get();
    final docs = data.docs;
    for (var element in docs) {
      DateTime time =
          DateTime.parse(FDate.yMd(element['bookedDate'].replaceAll('/', '-')));
      if (time.month == month && time.year == year && time.day == day) {
        fee = fee! + element['estimatedFee'];
        apps = apps! + 1;
      }
    }
    print(fee);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              S.of(context).profile_DoanhThu,
              style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24,),
            CustomSlidingSegmentedControl<int>(
              fixedWidth: MediaQuery.of(context).size.width / 2 - 20,
              innerPadding: const EdgeInsets.all(4),
              initialValue: pageIndex,
              children: {
                0: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    S.of(context).revenue_DoanhThuNgay,
                    style: FTypoSkin.buttonText2.copyWith(color: FColorSkin.primary),
                  ),
                ),
                1: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(S.of(context).revenue_DoanhThuThang,
                      style: FTypoSkin.buttonText2.copyWith(color: FColorSkin.primary)),
                ),
              },
              decoration: BoxDecoration(
                color: FColorSkin.primaryBackground,
                borderRadius: BorderRadius.circular(40),
              ),
              thumbDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInToLinear,
              onValueChanged: (v) {
                pageIndex = v;
                setState(() {});
              },
            ),
            const SizedBox(height: 16,),
            pageIndex == 0 ? buildDaily() : buildMonthly()
          ],
        ),
      ),
    );
  }

  Widget buildDaily(){
    return Column(
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
          child: _dateField(
              title: S.of(context).revenue_ChonNgay,
              hintText: S.of(context).revenue_ChonNgay,
              controller: dailyTEC,
              isRequire: false,
              isEnable: true,
              isDatePicker: true,
              isSuffixIcon: true,
              onTap: () {
                showFDatePicker(dailyTEC, S.of(context).revenue_ChonNgay);
              }),
        ),
        if (fee != null)
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              boxShadow: FElevation.elevation,
              borderRadius: BorderRadius.circular(8),
              color: FColorSkin.white
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).revenue_DoanhThuTrongNgay,style: FTypoSkin.subtitle3.copyWith(color: FColorSkin.subtitle),),
                      Text(
                        ConvertUtils.formatCurrency(fee),
                        style: FTypoSkin.label3.copyWith(color: FColorSkin.title),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).revenue_SoLichHen,style: FTypoSkin.subtitle3.copyWith(color: FColorSkin.subtitle)),
                      Text(
                        apps.toString(),
                        style: FTypoSkin.label3.copyWith(color: FColorSkin.title),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
  Widget buildMonthly(){
    return Column(
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
          child: _dateField(
              title: S.of(context).revenue_ChonThang,
              hintText: S.of(context).revenue_ChonThang,
              controller: monthlyTEC,
              isRequire: false,
              isEnable: true,
              isDatePicker: true,
              isSuffixIcon: true,
              onTap: () async{
                await showFMBS(
                context: context,
                builder: (context) => FDatePicker(S.of(context).revenue_ChonThang,
                    buttonTitle: S.of(context).common_Chon,
                    dayVisible: false,
                    controller: monthlyTEC,
                    initDateTime: monthlyTEC.text.isEmpty ? DateTime.now() : temp
                )
                )
                    .then((value) async {
                  if (value is DateTime) {
                    temp = value;
                    monthlyTEC.text = await value.formattedMonth();
                    if(mounted){
                      LoadingCore.loadingDialogIos(context);
                    }
                    await fetchMonthlyData(temp);
                    if(mounted){
                      Navigator.of(context).pop();
                    }
                  }
                  setState(() {});
                });
              }),
        ),
        if(monthlyTEC.text != '')
        SizedBox(
          width: MediaQuery.of(context).size.width * 2.5,
          child: SfCartesianChart(
            trackballBehavior: TrackballBehavior(
                lineColor: FColorSkin.border1,
                activationMode: ActivationMode.singleTap,
                shouldAlwaysShow: true,
                enable: true,
                // builder: (context, trackballDetails) {
                //   return Container(
                //     decoration: BoxDecoration(
                //       color: FColorSkin.white,
                //       borderRadius: BorderRadius.circular(8),
                //       boxShadow: FElevation.elevation,
                //     ),
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Text(
                //           FDate.dMy(trackballDetails.point?.x ?? ''),
                //           style: FTypoSkin.subtitle4
                //               .copyWith(color: FColorSkin.subtitle),
                //         ),
                //         SizedBox(
                //           height: 4,
                //         ),
                //         Text(
                //           ConvertUtils.formatCurrency(
                //               trackballDetails.point?.y?.toInt()),
                //           style: FTypoSkin.title6
                //               .copyWith(color: FColorSkin.title),
                //         )
                //       ],
                //     ),
                //   );
                // },
                tooltipSettings: InteractiveTooltip(
                    color: FColorSkin.white,
                    format: 'point.x\npoint.y',
                    borderRadius: 8,
                    textStyle:
                    FTypoSkin.title6.copyWith(color: FColorSkin.title),
                    enable: true,
                    canShowMarker: false,
                    arrowWidth: 0),
                markerSettings: const TrackballMarkerSettings(
                  // shape: DataMarkerType.circle,
                  markerVisibility: TrackballVisibilityMode.visible,
                  borderWidth: 5,
                  borderColor: FColorSkin.primary,
                  color: FColorSkin.white,
                ),
                lineType: TrackballLineType.vertical),
            plotAreaBorderWidth: 0,
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: NumericAxis(
              // numberFormat: NumberFormat.compact(),
              plotOffset: 5,
              initialVisibleMaximum: 5,
              initialVisibleMinimum: 1,
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
              majorGridLines: const MajorGridLines(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              axisLabelFormatter: (axisLabelRenderArgs) {
                final value = axisLabelRenderArgs.value.toInt();
                return ChartAxisLabel(
                  value.toString(),
                  FTypoSkin.label5.copyWith(color: FColorSkin.subtitle),
                );
              },
            ),
            primaryYAxis: NumericAxis(
              //số label ở mỗi 100 pixel
              maximumLabels: 1,
              numberFormat: NumberFormat.decimalPattern(),
              majorTickLines: const MajorTickLines(size: 0),
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              axisLabelFormatter: (axisLabelRenderArgs) {
                if (axisLabelRenderArgs.value == 0) {
                  return ChartAxisLabel(
                      '0 VNĐ',
                      FTypoSkin.label5
                          .copyWith(color: FColorSkin.subtitle));
                }
                return ChartAxisLabel(
                    ConvertUtils.formatCurrency(axisLabelRenderArgs.value)
                        .toString(),
                    FTypoSkin.label5.copyWith(color: FColorSkin.subtitle));
              },
            ),
            series: <CartesianSeries>[
              AreaSeries<ChartData, int>(
                  enableTooltip: true,
                  borderDrawMode: BorderDrawMode.top,
                  borderColor: FColors.purple6,
                  borderWidth: 1,
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  emptyPointSettings: const EmptyPointSettings(mode: EmptyPointMode.zero),
                  gradient: LinearGradient(
                      colors: [
                        const Color(0x00705dcf).withOpacity(0.15),
                        const Color(0x00705dcf)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ],
          ),
        ),

      ],
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
        const SizedBox(
          height: 8,
        ),
        FTextFormField(
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

class ChartData {
  ChartData(this.x, this.y);

  final int? x;
  final num? y;
}
