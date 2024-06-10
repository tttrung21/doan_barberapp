import 'package:doan_barberapp/utils/ConvertUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/DropdownItem.dart';
import '../../../components/skin/color_skin.dart';
import '../../../components/skin/typo_skin.dart';
import '../../../components/style/button_size.dart';
import '../../../components/style/icon_data.dart';
import '../../../components/style/input_size.dart';
import '../../../components/widget/app_bar.dart';
import '../../../components/widget/filled_button.dart';
import '../../../components/widget/icon.dart';
import '../../../components/widget/text_field.dart';
import '../../../generated/l10n.dart';
import '../../../shared/constant.dart';

class BTSService extends StatefulWidget {
  const BTSService({Key? key, this.selectedService, this.data})
      : super(key: key);

  final List<DropdownItem>? selectedService;
  final List<DropdownItem>? data;

  @override
  State<BTSService> createState() => _BTSSystemSPState();
}

class _BTSSystemSPState extends State<BTSService> {
  final _searchController = TextEditingController();
  final _scrollCtl = ScrollController();
  List<DropdownItem>? _selectedService;
  List<DropdownItem>? data = [];
  List<DropdownItem>? _listSearch = [];
  bool? isFirstItem;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    _listSearch = data;
    if (widget.selectedService != null) {
      _selectedService = widget.selectedService;
    }
    isFirstItem = _selectedService == null;
    // setState(() {});
  }

  bool checkChosenService(DropdownItem item) {
    if (_selectedService != null) {
      if (( _selectedService!.any((element) => element == item))) {
        return true;
      }
    }
    return false;
  }

  void _onSearch(String textSearch) {
    _listSearch = data?.where((e) {
      return e.name
              ?.wUnicodeToAscii()
              .contains(textSearch.toLowerCase().wUnicodeToAscii()) ??
          false;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: FColorSkin.white,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(64.0 + ((data?.isNotEmpty ?? false) ? 56 : 0)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 4),
                child: Container(
                  height: 4,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Color(0xffEAEAEA),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              FAppBar(
                title: Text(
                  S.of(context).booking_HintDichVu,
                  style: FTypoSkin.title3
                      .copyWith(color: FColorSkin.title, height: 0),
                ),
                centerTitle: true,
                actions: [
                  FFilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: FColorSkin.transparent,
                    child: FIcon(
                      icon: FOutlined.e_remove,
                      color: FColorSkin.subtitle,
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
              PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: (data?.isNotEmpty ?? false)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: FTextField(
                          maxLines: 1,
                          controller: _searchController,
                          borderColor: FColorSkin.transparent,
                          focusColor: FColorSkin.transparent,
                          backgroundColor: FColorSkin.grey2,
                          size: FInputSize.size40,
                          prefixIcon: FIcon(
                            icon: FOutlined.search,
                            size: 16,
                            color: FColorSkin.subtitle,
                          ),
                          hintText: S.of(context).common_TimKiem,
                          onClear: () {
                            _listSearch = null;
                            _searchController.clear();
                            _onSearch(_searchController.text);
                          },
                          onChanged: (v) {
                            if (mounted) {
                              setState(() {
                                _onSearch(v);
                              });
                            }
                          },
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
        body: data?.isNotEmpty ?? false
            ? _listSearch?.isNotEmpty ?? false
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: _scrollCtl,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var item in _listSearch ?? <DropdownItem>[]) ...[
                          CupertinoButton(
                            onPressed: () {
                              print('press');
                              if(isFirstItem!) {
                                _selectedService = [];
                                isFirstItem = false;
                              }
                              if (checkChosenService(item)) {
                                _selectedService?.remove(item);
                              } else {
                                _selectedService?.add(item);
                              }
                              setState(() {});
                            },
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name ?? '',
                                        style: FTypoSkin.label4.copyWith(
                                            color: FColorSkin.label, height: 1),
                                      ),
                                      const SizedBox(height: 4,),
                                      Text(
                                        '${NumberFormat.decimalPattern().format(item.price)} VND' ?? '',
                                        style: FTypoSkin.subtitle2.copyWith(
                                            color: FColorSkin.subtitle, height: 1),
                                      ),
                                    ],
                                  ),
                                ),
                                Checkbox(
                                    value: checkChosenService(item),
                                    onChanged: (value) {
                                      print(value);
                                      if(isFirstItem!) {
                                        _selectedService = [];
                                        isFirstItem = false;
                                      }
                                      if (checkChosenService(item)) {
                                        _selectedService?.remove(item);
                                      } else {
                                        _selectedService?.add(item);
                                      }
                                      setState(() {});
                                    })
                              ],
                            ),
                          ),
                          if (item != _listSearch?.last) Divider()
                        ]
                      ],
                    ),
                  )
                : BuildEmptySearch(context)
            : BuildEmptyData(title: S.of(context).booking_KhongCoDichVu),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0,
                MediaQuery.of(context).viewInsets.bottom + 8.0),
            child: FFilledButton(
              size: FButtonSize.size48,
              textColor: _selectedService != null
                  ? FColorSkin.white
                  : FColorSkin.disable2,
              backgroundColor: _selectedService != null
                  ? FColorSkin.primary
                  : FColorSkin.disable,
              onPressed: _selectedService != null
                  ? () {
                      Navigator.of(context).pop(_selectedService);
                    }
                  : null,
              child: Center(
                child: Text(S.of(context).common_Chon),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
