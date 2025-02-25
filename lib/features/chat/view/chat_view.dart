import 'package:ai_chat/core/enums/chat_messag_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/components/widgets/custom_text_field.dart';
import '../state/chat_state.dart';
import '../widgets/ai_chat_bubble.dart';
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
  Widget build(BuildContext context) {
    final state = ref.watch(chatStateProvider);
    final messages =
        ref.watch(chatStateProvider.select((state) => state.messages));
    final theme = ref.read(chatStateProvider.notifier).themeMode;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Color(0xFFE6E5EA),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Switch(
                      value: theme == ThemeMode.dark,
                      onChanged: (val) {
                        ref.read(chatStateProvider.notifier).toggleTheme(val);
                      }),
                  Row(
                    children: [
                      Icon(Icons.logo_dev),
                      Text(
                        ' Chat  ',
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.menu_open_rounded),
                  ),
                ],
              ),
            ),

            // Chat Messages Section
            Expanded(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Color(0xFFE6E5EA),
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
                            style: TextStyle(color: Colors.black87),
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
                                padding: const EdgeInsets.only(bottom: 12.0),
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
                                padding: const EdgeInsets.only(bottom: 12.0),
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
                      if (state.isLoading)
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.deepPurple),
                            ),
                          ),
                        ),

                      // Error Message at the Bottom
                      if (state.errorMessage != null)
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(state.errorMessage!),
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
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(onTap: () {}, child: Icon(Icons.attach_file)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  fillColor: Colors.white,
                  hintText: 'What’s on your mind?',
                  controller: _chatController,
                  keyboardType: TextInputType.multiline,
                  maxLines: double.maxFinite.floor(),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                  onTap: () {},
                  child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Icon(Icons.mic))),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  ref.read(chatStateProvider.notifier).sendQuery(
                      message: _chatController.text,
                      type: ChatMessageType.text);
                  _chatController.clear();
                },
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                  margin: const EdgeInsets.only(top: 12),
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
    );
    ;
  }
}
