import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/common/DropdownItem.dart';
import 'package:doan_barberapp/components/style/button_size.dart';
import 'package:doan_barberapp/components/widget/SnackBar.dart';
import 'package:doan_barberapp/components/widget/bottom_sheet.dart';
import 'package:doan_barberapp/components/widget/text_button.dart';
import 'package:doan_barberapp/project/booking/widgets/BTSService.dart';
import 'package:doan_barberapp/project/booking/widgets/CommonDialog.dart';
import 'package:doan_barberapp/shared/constant.dart';
import 'package:doan_barberapp/shared/models/AppointmentItem.dart';
import 'package:doan_barberapp/shared/repository/DataRepository.dart';
import 'package:doan_barberapp/utils/DeviceUtils.dart';
import 'package:doan_barberapp/utils/Loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/skin/color_skin.dart';
import '../../../components/skin/typo_skin.dart';
import '../../../components/style/icon_data.dart';
import '../../../components/style/input_size.dart';
import '../../../components/widget/FDatePicker.dart';
import '../../../components/widget/filled_button.dart';
import '../../../components/widget/form.dart';
import '../../../components/widget/icon.dart';
import '../../../components/widget/text_form_field.dart';
import '../../../generated/l10n.dart';
import '../../../utils/ConvertUtils.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({super.key, this.listBarber});

  final List<QueryDocumentSnapshot>? listBarber;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final ScrollController _scrollController1 = ScrollController();
  String? datePicked;
  String? pickedBarberId;
  String? pickedBarber;
  String? timePicked;
  int estimatedFee = 0;
  String services = '';
  List<DropdownItem>? listService;
  bool isFirstService = true;

  List<QueryDocumentSnapshot>? listBarber;
  DateTime now = DateTime.now();

  TextEditingController serviceTEC = TextEditingController();
  TextEditingController dateTEC = TextEditingController();
  TextEditingController timeSlotTEC = TextEditingController();

  Future<void> showFDatePicker(
      TextEditingController controller, String title) async {
    await showFMBS(
            context: context,
            builder: (context) => FDatePicker(title,
                buttonTitle: S.of(context).common_Chon,
                controller: controller,
                minimumDate: now.copyWith(hour: 0,minute: 0,second: 0,millisecond: 0,microsecond: 0),
                initDateTime: controller.text.isEmpty
                    ? now
                    : DateTime.parse(
                        FDate.yMd(controller.text.replaceAll('/', '-')))))
        .then((value) {
      if (value is DateTime) {
        datePicked = FDate.dMy(value);
        controller.text = datePicked!;
      }
      setState(() {});
    });
  }

  Future<bool> isTimeSlotBooked(
      String? date, String? timeSlot, String? barberId) async {
    try {
      // Get the current date and time
      if(date != null) {
        DateTime now = DateTime.now();
        DateTime selectedDate = DateTime.parse(
            FDate.yMd(date.replaceAll('/', '-')));

        // Check if the selected date is today
        if (selectedDate.year == now.year &&
            selectedDate.month == now.month &&
            selectedDate.day == now.day) {
          // Get the current hour and minute
          int currentHour = now.hour;
          int currentMinute = now.minute;

          // Parse the time slot
          List<String> parts = timeSlot!.split(':');
          int slotHour = int.parse(parts[0]);
          int slotMinute = int.parse(parts[1]);

          // Check if the time slot has already passed
          if (slotHour < currentHour ||
              (slotHour == currentHour && slotMinute <= currentMinute)) {
            return true; // Time slot has already passed
          }
        }
      }
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('bookedDate', isEqualTo: date)
          .where('bookedTime', isEqualTo: timeSlot)
          .where('barberId', isEqualTo: barberId)
          .get();

      return snapshot.docs
          .isNotEmpty; // Return true if there is at least one appointment for the given date and time slot
    } catch (e) {
      print('Error checking if time slot is booked: $e');
      return false; // Return false in case of error
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listBarber = widget.listBarber ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 76,
          leading: FTextButton(
              child: FIcon(
                icon: FOutlined.left_arrow,
                color: FColorSkin.white,
              ),
              onPressed: () => Navigator.of(context).pop()),
          elevation: 0,
          backgroundColor: FColorSkin.primary,
          titleSpacing: 0,
          title: Text(
            S.of(context).booking_DatLichHen,
            style:
                FTypoSkin.title2.copyWith(color: FColorSkin.white, height: 0),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dateField(
                    title: S.of(context).booking_DichVu,
                    hintText: S.of(context).booking_HintDichVu,
                    controller: serviceTEC,
                    isRequire: false,
                    isEnable: true,
                    isSuffixIcon: true,
                    onTap: () async {
                      LoadingCore.loadingDialogIos(context);
                      final data = await FirebaseFirestore.instance
                          .collection('services')
                          .get();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      List<DropdownItem> dropdownItems =
                          DropdownItem.fromJsonToList(
                              data.docs.map((doc) => doc.data()).toList());
                      if (context.mounted) {
                        print(listService);
                        final res = await showFMBS(
                            height: DeviceUtils.size.height * 600 / 896,
                            context: context,
                            builder: (context) => BTSService(
                                  data: dropdownItems,
                                  selectedService: listService,
                                ),
                            isDismissible: false);
                        if (res != null) {
                          listService = res;
                          services = '';
                          serviceTEC.text = '';
                          estimatedFee = 0;
                          isFirstService = true;
                          for (DropdownItem item in listService!) {
                            if (isFirstService) {
                              services = item.name!;
                              isFirstService = false;
                            } else {
                              services += ', ${item.name!}';
                            }
                            estimatedFee += item.price!;
                          }
                          serviceTEC.text =
                              services == '' ? serviceTEC.text : services;
                        }
                        setState(() {});
                        print(services);
                        print(serviceTEC.text);
                      }
                    }),
                if (listService != null)
                  const SizedBox(
                    height: 16,
                  ),
                if (listService != null)
                  Text(
                      '${S.of(context).booking_ChiPhi}: ${NumberFormat.decimalPattern().format(estimatedFee)} VND',
                      style:
                          FTypoSkin.title4.copyWith(color: FColorSkin.title)),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  S.of(context).booking_ChonBarber,
                  style: FTypoSkin.title4.copyWith(color: FColorSkin.title),
                ),
                listBarber!.isEmpty
                    ? BuildEmptyData(title: S.of(context).booking_KhongCoBarber)
                    : SizedBox(
                        height: 150,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          scrollDirection: Axis.horizontal,
                          itemCount: listBarber?.length ?? 0,
                          itemBuilder: (context, index) {
                            final barberData = listBarber?[index].data()
                                as Map<String, dynamic>?;
                            return Container(
                              width: 150,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: pickedBarberId == barberData?['uid']
                                      ? FColorSkin.primary
                                      : FColorSkin.white,
                                  border: Border.all(
                                      color: FColorSkin.primary, width: 1)),
                              child: CupertinoButton(
                                  onPressed: () {
                                    pickedBarberId = barberData?['uid'];
                                    pickedBarber = barberData?['name'];
                                    timePicked = null;
                                    setState(() {});
                                  },
                                  child: Column(
                                    children: [
                                      BuildAvatarWithUrl(barberData?['profilePic'],size: 60),
                                      Text(
                                        barberData?['name'] ?? '',
                                        style: FTypoSkin.subtitle1.copyWith(
                                            color:
                                                pickedBarberId == barberData?['uid']
                                                    ? FColorSkin.white
                                                    : FColorSkin.primary),
                                      ),
                                    ],
                                  )),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 8,
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 16,
                ),
                _dateField(
                    title: S.of(context).booking_ChonNgay,
                    hintText: S.of(context).booking_HintChonNgay,
                    controller: dateTEC,
                    isRequire: false,
                    isEnable: true,
                    isSuffixIcon: true,
                    isDatePicker: true,
                    onTap: () {
                      showFDatePicker(dateTEC, S.of(context).booking_ChonNgay);
                    }),
                const SizedBox(
                  height: 16,
                ),
                if (pickedBarberId != null && datePicked != null)
                  Text(
                    S.of(context).booking_ChonTimeSlot,
                    style: FTypoSkin.title4.copyWith(color: FColorSkin.title),
                  ),
                if (pickedBarberId != null && datePicked != null)
                  const SizedBox(
                    height: 16,
                  ),
                if (pickedBarberId != null && datePicked != null)
                  Wrap(
                    spacing: 28,
                    runSpacing: 12,
                    direction: Axis.horizontal,
                    children: timeSlot.map((slot) {
                      return FutureBuilder(
                        future: isTimeSlotBooked(datePicked, slot, pickedBarberId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox();
                          } else if (snapshot.hasError) {
                            // Show error message if an error occurs
                            return Text(S.of(context).common_LoiXayRa);
                          } else {
                            bool isBooked = snapshot.data == true;
                            return CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: isBooked
                                  ? null
                                  : () {
                                      timePicked = slot;
                                      setState(() {});
                                    },
                              child: Container(
                                alignment: Alignment.center,
                                width: 60,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: isBooked
                                      ? FColorSkin.grey2
                                      : timePicked == slot
                                          ? FColorSkin.primary
                                          : FColorSkin.white,
                                  border: isBooked
                                      ? null
                                      : Border.all(color: FColorSkin.primary),
                                ),
                                child: Text(slot,
                                    style: FTypoSkin.subtitle3
                                        .copyWith(color: FColorSkin.subtitle)),
                              ),
                            );
                          }
                        },
                      );
                    }).toList(),
                  )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: FFilledButton(
                  onPressed: () async {
                    if (services == '') {
                      SnackBarCore.fail(title: S.of(context).booking_TBChonDichVu);
                    } else if (pickedBarberId == null) {
                      SnackBarCore.fail(title: S.of(context).booking_TBChonBarber);
                    } else if (datePicked == null) {
                      SnackBarCore.fail(title: S.of(context).booking_TBChonNgay);
                    } else if (timePicked == null) {
                      SnackBarCore.fail(title: S.of(context).booking_TBChonTimeSlot);
                    } else {
                      await showDialog(
                        context: context,
                        builder: (context) => CommonDialog(
                          type: EnumTypeDialog.success,
                          title: S.of(context).booking_XacNhan,
                          cancelTitle: S.of(context).common_QuayLai,
                          continueTitle: S.of(context).booking_DatLichBtn,
                          service: services,
                          barberName: pickedBarber,
                          date: datePicked,
                          timeSlot: timePicked,
                          fee: estimatedFee,
                          onContinue: () async{
                            try {
                              LoadingCore.loadingDialogIos(context);
                              DataRepository dataRepository = DataRepository();
                              await dataRepository.bookAppointment(
                                  AppointmentItem(
                                      userId: FirebaseAuth.instance.currentUser
                                          ?.uid,
                                      barberId: pickedBarberId,
                                      bookedDate: datePicked,
                                      bookedTime: timePicked,
                                      appointmentId: '',
                                      barberName: pickedBarber,
                                      services: services,
                                      estimatedFee: estimatedFee,
                                      isCancelled: 0));
                              await Future.delayed(const Duration(seconds: 0));
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                              await Future.delayed(const Duration(seconds: 0));
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                SnackBarCore.success(
                                    title: S.of(context).common_ThanhCong);
                                Navigator.of(context).pop();
                              }
                            }
                            on FirebaseException catch (e){
                              SnackBarCore.fail(title: e.code);
                            }
                            catch(e){
                              SnackBarCore.fail(title: e.toString());
                            }
                          },
                        ),
                      );
                    }
                  },
                  size: FButtonSize.size48,
                  backgroundColor: FColorSkin.primary,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).booking_DatLichBtn,
                        style: FTypoSkin.buttonText1
                            .copyWith(color: FColorSkin.white),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
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
        SizedBox(
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
