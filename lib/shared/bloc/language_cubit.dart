import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<String> {
  LanguageCubit() : super('vi'); // Default language is Vietnamese

  void loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('language');
    if (language != null) {
      emit(language);
    }
  }

  void changeLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    emit(language);
  }
}