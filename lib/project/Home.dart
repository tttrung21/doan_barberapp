import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:doan_barberapp/project/booking/widgets/CommonDialog.dart';
import 'package:doan_barberapp/project/service/ui/ServiceScreen.dart';
import 'package:doan_barberapp/shared/bloc/language_cubit.dart';
import 'package:doan_barberapp/shared/repository/DataRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/widget/custom_bottombar_button.dart';
import '../generated/l10n.dart';
import '../shared/bloc/auth_bloc/auth_bloc.dart';
import '../utils/Loading.dart';
import 'account/auth/Login.dart';
import 'booking/ui/BookingScreen.dart';
import 'booking/ui/ring.dart';
import 'history/ui/HistoryScreen.dart';
import 'home/ui/HomeScreen.dart';
import 'account/profile/ui/ProfileScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int indexScreen = 0;
  List<Widget> listScreen = [];
  static StreamSubscription<AlarmSettings>? subscription;

  changeScreen(int index) {
    setState(() {
      indexScreen = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listScreen = [
      HomeScreen(
        callbackProfile: () => changeScreen(3),
        callbackService: () => changeScreen(1),
      ),
      ServiceScreen(),
      HistoryScreen(),
      ProfileScreen()
    ];
    if (Alarm.android) {
      checkAndroidNotificationPermission();
      checkAndroidScheduleExactAlarmPermission();
      checkAndroidExternalStoragePermission();
    }
    subscription ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
  }


  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) =>
            ExampleAlarmRingScreen(alarmSettings: alarmSettings),
      ),
    );
  }

  Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      alarmPrint('Requesting notification permission...');
      final res = await Permission.notification.request();
      alarmPrint(
        'Notification permission ${res.isGranted ? '' : 'not '}granted',
      );
    }
  }

  Future<void> checkAndroidExternalStoragePermission() async {
    final status = await Permission.storage.status;
    if (status.isDenied) {
      alarmPrint('Requesting external storage permission...');
      final res = await Permission.storage.request();
      alarmPrint(
        'External storage permission ${res.isGranted ? '' : 'not'} granted',
      );
    }
  }

  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    alarmPrint('Schedule exact alarm permission: $status.');
    if (status.isDenied) {
      alarmPrint('Requesting schedule exact alarm permission...');
      final res = await Permission.scheduleExactAlarm.request();
      alarmPrint(
        'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted',
      );
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<LanguageCubit, String>(
        builder: (context, state) {
          return FloatingActionButton.extended(
            backgroundColor: Colors.transparent,
            elevation: 0,
            disabledElevation: 0,
            focusElevation: 0,
            hoverElevation: 0,
            highlightElevation: 0,
            onPressed: () {},
            label: SizedBox(
              width: 140 / 415 * MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  BlocConsumer<AuthBloc, AuthState>(
                    listenWhen: (previous, current) => current is UnauthenticatedState,
                    listener: (context, state) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                          (route) => false);
                    },
                    builder: (context, state) {
                      return CustomBottomBarButton(
                        text: S.of(context).booking_DatNgay,
                        press: () async {
                          if (state.profile == null) {
                            showDialog(
                              context: context,
                              builder: (context) => CommonDialog(
                                type: EnumTypeDialog.info,
                                title: S.of(context).common_ThongBao,
                                subtitle: S.of(context).common_DNTruoc,
                                cancelTitle: S.of(context).common_QuayLai,
                                continueTitle: S.of(context).common_DangNhap,
                                onContinue: () {
                                  Navigator.pop(context);
                                  context
                                      .read<AuthBloc>()
                                      .add(LogOutRequestedEvent());
                                },
                              ),
                            );
                          } else {
                            LoadingCore.loadingDialogIos(context);
                            final docs = await DataRepository().getBarbers();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookingScreen(
                                        listBarber: docs,
                                      )));
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SingleChildScrollView(child: listScreen[indexScreen])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    changeScreen(0);
                  },
                  icon: Icon(
                    CupertinoIcons.home,
                    color: indexScreen == 0
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                  )),
              IconButton(
                  onPressed: () {
                    changeScreen(1);
                  },
                  icon: Icon(Icons.cut,
                      color: indexScreen == 1
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary)),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    changeScreen(2);
                  },
                  icon: Icon(Icons.history,
                      color: indexScreen == 2
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary)),
              IconButton(
                  onPressed: () {
                    changeScreen(3);
                  },
                  icon: Icon(CupertinoIcons.person_alt_circle,
                      color: indexScreen == 3
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary)),
            ],
          )
        ],
      ),
    );
  }
}
