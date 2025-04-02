import 'package:ai_chat/core/services/local/user_pref.dart';
import 'package:ai_chat/core/constants/theme/theme_constants.dart';
import 'package:ai_chat/features/theme/repository/theme_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/theme_model.dart';


//STATE CLASS
class ThemeState {
  final ThemeModel themeModel;
  final bool isLoading;

  ThemeState({
    required this.themeModel,
    this.isLoading = false,
  });

  ThemeState copyWith({
    ThemeModel? themeModel,
    bool? isLoading,
  }) {
    return ThemeState(
      themeModel: themeModel ?? this.themeModel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}



//STATE NOTIFIER
class ThemeStateNotifier extends StateNotifier<ThemeState> {
  final ThemeRepository themeRepository;
  ThemeStateNotifier({required this.themeRepository})
      : super(ThemeState(
            themeModel: ThemeModel(themeData: ThemeManager.light, isDarkMode: false))) {
    _loadSavedTheme();
  }

  bool get isDarkMode => state.themeModel.isDarkMode;

  Future<void> _loadSavedTheme() async {
    final currentThemeIsDark = await themeRepository.getSavedTheme();
      state = state.copyWith(
      themeModel: ThemeModel(
        themeData: currentThemeIsDark ? ThemeManager.dark : ThemeManager.light,
        isDarkMode: currentThemeIsDark,
      ),
    );
  }


  Future<void> toggleTheme(bool val) async {
    //final isDarkMode = !state.themeModel.isDarkMode;
    await themeRepository.saveTheme(val);
    state = state.copyWith(
      themeModel: ThemeModel(
        themeData: val ? ThemeManager.dark : ThemeManager.light,
        isDarkMode: val,
      ),
    );
  }
}

final themeRepositoryProvider = Provider((_) => ThemeRepository(UserPreferences()));

final themeStateProvider =
StateNotifierProvider<ThemeStateNotifier, ThemeState>((ref) {
  return ThemeStateNotifier(themeRepository: ref.watch(themeRepositoryProvider));
});