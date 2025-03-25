import 'package:ai_chat/core/theme/theme_constants.dart';
import 'package:ai_chat/features/chat/state/chat_state.dart';
import 'package:ai_chat/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/theme/state/theme_state.dart';

void main() {
  runApp(ProviderScope(child: const AiChatApp()));
}


class AiChatApp extends ConsumerWidget {
  const AiChatApp({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeStateProvider);
     return AnimatedTheme(
       data: themeState.themeModel.themeData,
       duration: Duration(milliseconds: 300),
       child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: themeState.themeModel.themeData,
        routerConfig: navigationRoutes,
           ),
     );
  }
}
