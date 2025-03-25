import '../../../core/services/local/user_pref.dart';

class ThemeRepository {
  final UserPreferences userPref;

  ThemeRepository(this.userPref);
  Future<bool> getSavedTheme() async {
    // Fetch the saved theme preference (e.g., from SharedPreferences)
     return userPref.getCurrentTheme();
  }

  Future<void> saveTheme(bool isDarkMode) async {
    // Save the theme preference
     await userPref.setTheme(isDarkMode);
  }
}