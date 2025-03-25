import 'package:ai_chat/features/theme/state/theme_state.dart';
import 'package:ai_chat/features/theme/view/theme_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/colors/colors.dart';
import '../../../core/theme/theme_constants.dart';

class MenuSlider extends ConsumerWidget {
  const MenuSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ThemeManager.getTheme(context);
    final themeState = ref.watch<ThemeState>(themeStateProvider);
    final isDarkMode = themeState.themeModel.isDarkMode;
    return Material(
      elevation: 0.9,
      child: Container(
        color:  isDarkMode == true
            ? kColorGrey.shade900
            : theme.colorScheme.shadow,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 20, 20, 10),
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: theme.colorScheme.shadow,
                  blurRadius: 1,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menu',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).push(ThemeModeView.path);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Theme',
                          style: theme.textTheme.bodyLarge,
                        ),
                        Icon(Icons.arrow_forward_ios, size: 15,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
