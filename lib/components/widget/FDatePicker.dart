
import 'package:flutter/cupertino.dart';
import '../../generated/l10n.dart';
import '../../shared/routes.dart';
import '../../utils/ConvertUtils.dart';
import '../skin/color_skin.dart';
import '../skin/typo_skin.dart';
import '../style/button_size.dart';
import '../style/icon_data.dart';
import 'app_bar.dart';
import 'date_time_picker.dart';
import 'filled_button.dart';
import 'icon.dart';

// ignore: must_be_immutable
class FDatePicker extends StatefulWidget {
  final String title;
  DateTime minimumDate;
  DateTime maximumDate;
  int minimumYear;
  int maximumYear;
  final TextEditingController controller;
  final String? buttonTitle;
  final bool dayVisible;
  final bool useLeading;
  final FCupertinoDatePickerMode mode;
  Function? onClean;
  Function? onSecondBtnPress;
  String? secondBtnTitle;
  bool onlyYear;
  bool onlyQuarter;
  bool onlyMonth;
  final Function(String)? onChangeYear;
  final Function(String)? onChangeQuarter;
  final Function(String)? onChangeMonth;

  FDatePicker(
    this.title, {
    Key? key,
    required this.initDateTime,
    DateTime? minimumDate,
    int? minimumYear,
    DateTime? maximumDate,
    int? maximumYear,
    required this.controller,
    this.dayVisible = true,
    this.buttonTitle,
    this.onClean,
    this.mode = FCupertinoDatePickerMode.date,
    this.useLeading = true,
    this.onlyYear = false,
    this.onlyQuarter = false,
    this.onlyMonth = false,
    this.onChangeYear,
    this.onChangeQuarter,
    this.onChangeMonth,
    this.onSecondBtnPress,
    this.secondBtnTitle,
    this.initQuater,
    this.initMonth,
  })  : minimumYear = minimumYear ?? DateTime.now().year - 100,
        maximumYear = maximumYear ?? DateTime.now().year + 100,
        minimumDate = minimumDate ?? DateTime(DateTime.now().year - 100, 1, 1),
        maximumDate = maximumDate ?? DateTime(DateTime.now().year + 100, 1, 1),
        super(key: key);

  final DateTime initDateTime;
  final int? initQuater;
  final int? initMonth;

  @override
  _FDatePickerState createState() => _FDatePickerState();
}

class _FDatePickerState extends State<FDatePicker> {
  DateTime? _selectedDateTime;
  int _selectedYear = DateTime.now().year;
  int _selectedQuarter = ConvertUtils.findQuarter(DateTime.now().month);
  int _selectedMonth = DateTime.now().month;
  final List<int> _yearList = [];
  final List<int> _quarterList = [];
  final List<int> _monthList = [];
  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _QuarterController;
  late FixedExtentScrollController _MonthController;

  @override
  void initState() {
    _selectedDateTime = widget.initDateTime;
    if (widget.initQuater != null) {
      _selectedQuarter = widget.initQuater!;
    } else {
      _selectedQuarter = ConvertUtils.findQuarter(widget.initDateTime.month);
    }
    if (widget.initMonth != null) {
      _selectedMonth = widget.initMonth!;
    } else {
      _selectedMonth = widget.initDateTime.month;
    }
    widget.maximumYear = widget.maximumDate.year;
    widget.minimumYear = widget.minimumDate.year;
    super.initState();

    _selectedYear = widget.initDateTime.year;
    for (var i = widget.minimumYear; i <= widget.maximumYear; i++) {
      _yearList.add(i);
    }
    for (var i = 1; i <= 4; i++) {
      _quarterList.add(i);
    }
    final startMonth = (_selectedQuarter - 1) * 3 + 1;
    final endMonth = _selectedQuarter * 3;
    for (var i = startMonth; i <= endMonth; i++) {
      _monthList.add(i);
    }

    _yearController = FixedExtentScrollController(initialItem: _yearList.indexOf(widget.initDateTime.year));
    _QuarterController = FixedExtentScrollController(initialItem: _quarterList.indexOf(_selectedQuarter));
    _MonthController = FixedExtentScrollController(initialItem: _monthList.indexOf(_selectedMonth));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).padding,
      decoration: BoxDecoration(
        color: FColorSkin.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Wrap(
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: EdgeInsets.only(top: 8, bottom: 4),
              decoration: BoxDecoration(
                color: FColorSkin.grey3,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          FAppBar(
            centerTitle: true,
            leading: widget.useLeading
                ? FFilledButton.icon(
                    backgroundColor: FColorSkin.transparent,
                    onPressed: () => Navigator.pop(context),
                    child: FIcon(
                      icon: FOutlined.left_arrow,
                      color: FColorSkin.subtitle,
                    ),
                  )
                : SizedBox(),
            title: Text(
              widget.title,
              style: FTypoSkin.title4.copyWith(color: FColorSkin.title, height: 1),
            ),
            actions: [
              if (!widget.useLeading)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FFilledButton.icon(
                    backgroundColor: FColorSkin.transparent,
                    onPressed: () => Navigator.pop(context),
                    child: FIcon(icon: FOutlined.e_remove, color: FColorSkin.subtitle),
                  ),
                ),
            ],
          ),
          Container(
            height: 186,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: widget.onlyYear
                ? Column(
                    children: [
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 36,
                          onSelectedItemChanged: (int index) {
                            _selectedYear = _yearList[index];
                            widget.onChangeYear;
                            setState(() {});
                          },
                          useMagnifier: true,
                          magnification: 1.2,
                          squeeze: 1.10,
                          selectionOverlay:
                              CupertinoPickerDefaultSelectionOverlay(background: Color.fromARGB(30, 161, 161, 170)),
                          scrollController: _yearController,
                          children: _yearList
                              .map(
                                (item) => Center(
                                  child: Text(
                                    item.toString(),
                                    style: FTypoSkin.title4.copyWith(color: FColorSkin.title),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  )
                : widget.onlyQuarter
                    ? Column(
                        children: [
                          Expanded(
                            child: CupertinoPicker(
                              itemExtent: 36,
                              onSelectedItemChanged: (int index) {
                                _selectedQuarter = _quarterList[index];
                                widget.onChangeQuarter;
                                setState(() {});
                              },
                              useMagnifier: true,
                              magnification: 1.2,
                              squeeze: 1.10,
                              selectionOverlay:
                                  CupertinoPickerDefaultSelectionOverlay(background: Color.fromARGB(30, 161, 161, 170)),
                              scrollController: _QuarterController,
                              children: _quarterList
                                  .map(
                                    (item) => Center(
                                      child: Text(
                                        '${S.of(context).common_quy} $item',
                                        style: FTypoSkin.title4.copyWith(color: FColorSkin.title),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      )
                    : widget.onlyMonth
                        ? Column(
                            children: [
                              Expanded(
                                child: CupertinoPicker(
                                  itemExtent: 36,
                                  onSelectedItemChanged: (int index) {
                                    _selectedMonth = _monthList[index];
                                    widget.onChangeMonth;
                                    setState(() {});
                                  },
                                  useMagnifier: true,
                                  magnification: 1.2,
                                  squeeze: 1.10,
                                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                                      background: Color.fromARGB(30, 161, 161, 170)),
                                  scrollController: _MonthController,
                                  children: _monthList
                                      .map(
                                        (item) => Center(
                                          child: Text(
                                            '${S.of(context).common_Thang} $item',
                                            style: FTypoSkin.title4.copyWith(color: FColorSkin.title),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          )
                        : FCupertinoDatePicker(
                            use24hFormat: true,
                            mode: widget.mode,
                            dayVisible: widget.dayVisible,
                            maximumYear: widget.maximumYear,
                            maximumDate: widget.maximumDate,
                            minimumDate: widget.minimumDate,
                            minimumYear: widget.minimumYear,
                            initialDateTime: _selectedDateTime,
                            onDateTimeChanged: (value) async {
                              setState(() {
                                _selectedDateTime = value;
                              });
                            },
                          ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                if (widget.secondBtnTitle?.isNotEmpty ?? false)
                  Expanded(
                    child: FFilledButton(
                      onPressed: () {
                        CoreRoutes.instance.pop();
                        if (widget.onSecondBtnPress != null) {
                          widget.onSecondBtnPress!();
                        }
                      },
                      backgroundColor: FColorSkin.grey3,
                      size: FButtonSize.size48,
                      textColor: FColorSkin.subtitle,
                      child: Center(child: Text(widget.secondBtnTitle ?? '')),
                    ),
                  ),
                if (widget.secondBtnTitle?.isNotEmpty ?? false) SizedBox(width: 8),
                Expanded(
                  child: FFilledButton(
                    onPressed: () => Navigator.pop(
                        context,
                        widget.onlyYear
                            ? _selectedYear
                            : widget.onlyQuarter
                                ? _selectedQuarter
                                : widget.onlyMonth
                                    ? _selectedMonth
                                    : _selectedDateTime),
                    backgroundColor: FColorSkin.primary,
                    size: FButtonSize.size48,
                    child: Center(child: Text(widget.buttonTitle ?? S.of(context).common_Chon)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
