import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/theme/theme_constants.dart';
import '../state/theme_state.dart';

class ThemeModeView extends ConsumerWidget {
  static const String path = '/theme';
  const ThemeModeView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ThemeManager.getTheme(context);
    final themeState = ref.watch<ThemeState>(themeStateProvider);
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dark Mode',
                style: theme.textTheme.bodyLarge,
              ),
              Switch(
                  value: themeState.themeModel.isDarkMode,
                  onChanged: (val) {
                    val = !themeState.themeModel.isDarkMode;
                    ref
                        .read(themeStateProvider.notifier)
                        .toggleTheme(val);
                  })
            ],
          )
        ],),
      )),
    );
  }
}
