import 'package:ai_chat/features/chat/view/chat_view.dart';
import 'package:ai_chat/features/theme/view/theme_view.dart';
import 'package:ai_chat/splash.dart';
import 'package:go_router/go_router.dart';

final navigationRoutes = GoRouter(
  initialLocation: SplashView.path,
    routes: [
      GoRoute(
        path: ChatView.path,
        builder: (context, state) => const ChatView(),
      ),
      GoRoute(
        path: SplashView.path,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: ThemeModeView.path,
        builder: (context, state) => const ThemeModeView(),
      ),
    ]
);