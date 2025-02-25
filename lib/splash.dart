import 'package:ai_chat/features/chat/view/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  static final path = '/splash';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      _delay();
    });
    super.initState();
  }

  _delay() async {
    final router = GoRouter.of(context);
    await Future.delayed(Duration(milliseconds: 500));
    router.go(ChatView.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Icon(Icons.logo_dev),),
    );
  }
}

