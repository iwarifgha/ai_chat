import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String themeModeKey = 'isDarkMode';


  Future<bool> getCurrentTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeModeKey) ?? false;
  }

  Future<bool> setTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(themeModeKey, value);
  }
}
