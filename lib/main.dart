import 'package:alarm/alarm.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:doan_barberapp/components/skin/color_skin.dart';
import 'package:doan_barberapp/firebase_options.dart';
import 'package:doan_barberapp/project/Home.dart';
import 'package:doan_barberapp/shared/bloc/auth_bloc/auth_bloc.dart';
import 'package:doan_barberapp/shared/bloc/language_cubit.dart';
import 'package:doan_barberapp/shared/repository/AuthRepository.dart';
import 'package:doan_barberapp/shared/repository/UserRepository.dart';
import 'package:doan_barberapp/utils/DeviceUtils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Alarm.init();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();
  final botToastBuilder = BotToastInit();
  String _lang = 'vi';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _lang = prefs.getString('language') ?? 'vi';
      print('lang : $_lang');
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
                userRepository: RepositoryProvider.of<UserRepository>(context))
              ..add(AuthStartedEvent()),
          ),
          BlocProvider(create: (context) => LanguageCubit()..loadLanguage())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Locale(_lang),
          supportedLocales: S.delegate.supportedLocales,
          title: 'Flutter Demo',
          navigatorObservers: [BotToastNavigatorObserver()],
          builder: (context, child) {
            child = child ?? SizedBox();
            child = botToastBuilder(context, child);
            DeviceUtils.init(context);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  boldText: false, textScaler: TextScaler.linear(1.0)),
              child: child,
            );
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: FColorSkin.primary),
            useMaterial3: true,
          ),
          home: MyHomePage(),
        ),
      ),
    );
  }
}
