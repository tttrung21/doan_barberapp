import 'package:flutter/material.dart';

class CoreRouteNames {
  // ignore: constant_identifier_names
  // static const String LOGIN_MANUAL = '/LOGIN_MANUAL';
  // static const String SPLASH = '/SPLASH';
  // static const String HOME = '/HOME';
  // static const String NOTIFICATION = '/NOTIFICATION';
  // static const String NOTIFICATION_DETAIL = '/NOTIFICATION_DETAIL';
  // static const String FAQ = '/FAQ';
  // static const String CONTRACT = '/CONTRACT';
  // static const String STARTRIP = '/STARTRIP';
  // static const String BONUSES = 'Bonus';
  // static const String ANANLYZEFINAN = '/ANANLYZEFINAN';
}

/// Custom transition Fade navigation.
Route createFadeRouteWidget({Widget? pageNavigate, int? timeMilliseconds}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: timeMilliseconds ?? 0),
    pageBuilder: (context, animation, secondaryAnimation) => pageNavigate ?? SizedBox(),
    transitionsBuilder:
        (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

/// Custom transition Fade navigation.
Route createDownToUpRouteWidget({Widget? pageNavigate, int? timeMilliseconds}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: timeMilliseconds ?? 0),
    pageBuilder: (context, animation, secondaryAnimation) => pageNavigate ?? SizedBox(),
    transitionsBuilder:
        (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      final begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );
      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

class CoreRoutes {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory CoreRoutes() => _instance;

  CoreRoutes._internal();

  static final CoreRoutes _instance = CoreRoutes._internal();

  static CoreRoutes get instance => _instance;

  String currentRoutes = '';

  // Material RouteString
  Future<dynamic> navigateToRouteString(String routeName, {Object? arguments}) async =>
      navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);

  Future<dynamic> navigateAndRemove(String routeName, {Object? arguments}) async =>
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName,
        (Route<dynamic> route) => false,
        arguments: arguments,
      );

  Future<dynamic> navigateAndReplaceRouteString(String routeName, {Object? arguments}) async =>
      navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);

  dynamic pop({dynamic result}) => navigatorKey.currentState?.pop(result);

  void popUntil(bool Function(Route<dynamic>) predicate) => navigatorKey.currentState?.popUntil(predicate);

  // Material Routes
  Future<dynamic> navigateAndRemoveRoutes(dynamic route) async => navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => route),
        (Route<dynamic> route) => false,
      );

  Future<dynamic> navigatorPushRoutes(dynamic route) async => navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => route),
      );

  Future<dynamic> navigatorPushReplacementRoutes(dynamic route) async => navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => route),
      );

  // Fade Routes
  Future<dynamic> navigateAndRemoveFade(dynamic route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState?.pushAndRemoveUntil(
        createFadeRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond),
        (Route<dynamic> route) => false,
      );

  Future<dynamic> navigatorPushFade(dynamic route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState?.push(createFadeRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond));

  Future<dynamic> navigatorPushReplacementFade(dynamic route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState
          ?.pushReplacement(createFadeRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond));

  // Slide Routes
  Future<dynamic> navigateAndRemoveDownToUp(dynamic route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState?.pushAndRemoveUntil(
        createDownToUpRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond),
        (Route<dynamic> route) => false,
      );

  Future<dynamic> navigatorPushDownToUp(dynamic route, {int timeMillisecond = 350}) async => navigatorKey.currentState
      ?.push(createDownToUpRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond));

  Future<dynamic> navigatorPushReplacementDownToUp(dynamic route, {int timeMillisecond = 350}) async =>
      navigatorKey.currentState
          ?.pushReplacement(createDownToUpRouteWidget(pageNavigate: route, timeMilliseconds: timeMillisecond));
}
