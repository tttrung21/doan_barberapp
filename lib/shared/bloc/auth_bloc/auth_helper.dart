import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isAuth() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("is_auth") ?? false;
}

Future<void> setAuth(bool isAuth) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("is_auth", isAuth);
}