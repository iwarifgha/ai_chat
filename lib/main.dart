import 'package:ai_chat/core/theme/theme_constants.dart';
import 'package:ai_chat/core/theme/theme_state.dart';
import 'package:ai_chat/features/chat/state/chat_state.dart';
import 'package:ai_chat/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const AiChatApp()));
}


class AiChatApp extends ConsumerWidget {
  const AiChatApp({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(chatStateProvider.notifier).themeMode;
    return MaterialApp.router(
      theme: light,
      darkTheme: dark,
      themeMode:theme,
      routerConfig: navigationRoutes,
    );
  }
}
