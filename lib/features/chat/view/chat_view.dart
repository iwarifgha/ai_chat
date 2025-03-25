import 'package:ai_chat/core/constants/colors/colors.dart';
import 'package:ai_chat/core/theme/theme_constants.dart';
import 'package:ai_chat/features/chat/widgets/recording_wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/components/widgets/custom_text_field.dart';
import '../../theme/state/theme_state.dart';
import '../state/chat_state.dart';
import '../widgets/ai_chat_bubble.dart';
import '../widgets/menu_slider.dart';
import '../widgets/user_chat_bubble.dart';

class ChatView extends ConsumerStatefulWidget {
  static final path = '/chat_view';

  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final TextEditingController _chatController = TextEditingController();

  @override
  initState() {
    super.initState();
    _initSpeech();
  }

  _initSpeech() async {
    await ref.read(chatStateProvider.notifier).initializeVoiceService();
  }

  _sendQuery() {
    final state = ref.watch(chatStateProvider);
    if (state.isRecording == true) {
      ref.read(chatStateProvider.notifier).stopVoiceSessionAndSendQuery();
    }
    ref
        .read(chatStateProvider.notifier)
        .sendRegularQuery(message: _chatController.text);
    _chatController.clear();
  }

  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatStateProvider);
    final themeState = ref.watch(themeStateProvider);
    final isDarkMode = themeState.themeModel.isDarkMode;
    final messages =
        ref.watch(chatStateProvider.select((state) => state.messages));
    double menuWidth = MediaQuery.sizeOf(context).width * .8;
    final theme = ThemeManager.getTheme(context);

    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: menuWidth,
          child: MenuSlider(),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          left: isMenuOpen ? menuWidth : 0,
          right: isMenuOpen ? -menuWidth : 0,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            color: theme.primaryColor,
            child: Scaffold(
              backgroundColor: isDarkMode == true
                  ? kColorGrey.shade900
                  : theme.colorScheme.shadow,
              body: SafeArea(
                child: Column(
                  children: [
                    // Header Section
                    Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: theme.primaryColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            color: theme.colorScheme.shadow,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                  onTap: toggleMenu,
                                  child: Icon(
                                    isMenuOpen ? Icons.close : Icons.logo_dev,
                                    color: theme.colorScheme.onSecondary,
                                  )
                                  //isMenuOpen? Icon(Icons.close, c): Icon(Icons.logo_dev),
                                  ),
                              Text(
                                ' Chat  ',
                                style: theme.textTheme.titleSmall,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: toggleMenu,
                            child: Icon(
                              Icons.menu_open_rounded,
                              color: theme.colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Chat Messages Section
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: theme.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 1),
                              color: theme.colorScheme.shadow,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (messages.isEmpty)
                                Center(
                                  child: Text(
                                    'What are you looking for?',
                                    style: theme.textTheme.titleSmall,
                                  ),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: messages.length,
                                  itemBuilder: (context, index) {
                                    final message = messages[index];
                                    if (message.isUser) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: UserBubble(
                                          message: message.message,
                                          avatarUrl: message.avatarUrl ?? '',
                                          fileUrl: message.fileUrl,
                                          type: message.type,
                                          audioMessagePath: message.audioPath,
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: ChatBotBubble(
                                          message: message.message,
                                          avatarUrl: message.avatarUrl ?? '',
                                          businesses: message.businessData,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              // Loading Indicator at the Bottom
                              if (chatState.isLoading)
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          color: kColorPurple),
                                    ),
                                  ),
                                ),

                              // Error Message at the Bottom
                              if (chatState.errorMessage != null)
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: kColorRedAccent,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(chatState.errorMessage!),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      chatState.isRecording == true
                          ? IconButton(
                              icon: Icon(Icons.delete, color: kColorRedAccent),
                              onPressed: () {}, // Implement delete action
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: InkWell(
                                  onTap: () {},
                                  child: Icon(Icons.attach_file,
                                      color: kColorCyanAccent)),
                            ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: chatState.isRecording == true
                            ? RecordingWave()
                            : CustomTextField(
                                fillColor: theme.primaryColor,
                                hintText: 'What’s on your mind?',
                                controller: _chatController,
                                keyboardType: TextInputType.multiline,
                                maxLines: double.maxFinite.floor(),
                              ),
                      ),
                      const SizedBox(width: 8),
                      chatState.isRecording == false
                          ? InkWell(
                              onTap: () {
                                chatState.voiceServiceEnabled == true
                                    ? ref
                                        .read(chatStateProvider.notifier)
                                        .startVoiceSession()
                                    : null;
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child:
                                      Icon(Icons.mic, color: kColorCyanAccent)))
                          : SizedBox.shrink(),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          _sendQuery();
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: kColorPurple),
                          margin: const EdgeInsets.only(top: 5),
                          child: Icon(
                            Icons.arrow_upward_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
