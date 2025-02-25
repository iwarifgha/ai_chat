
import 'package:ai_chat/features/chat/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/chat_messag_type.dart';
import '../../../core/helpers/catch_error.dart';
import '../../../core/services/ai_service.dart';
import '../model/message.dart';

//--------STATE-------//
class ChatState {
  final List<Message> messages;
  final bool isLoading;
  final String? errorMessage;

  ChatState({
    required this.messages,
    this.isLoading = false,
    this.errorMessage,
  });

  ChatState copyWith({
    final List<Message>? messages,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

//--------STATE NOTIFIER-------//

class ChatStateNotifier extends StateNotifier<ChatState> {
  final ChatRepository chatRepository;

  final List<Message> _messages = [];

  ChatStateNotifier({required this.chatRepository})
      : super(ChatState(messages: []));


  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    state = state.copyWith(messages: _messages);
  }


  //SENDS A QUERY TO THE AI. I.E TEXT OR FILE QUERIES.
  Future<void> sendQuery({required String message,
    required ChatMessageType type}) async {
    state = state.copyWith(messages: _messages, isLoading: true);

    //add user message to the list
    _messages.add(Message(
        isUser: true,
        message: message,
        type: type,
        businessData: []));

    state = state.copyWith(messages: _messages, isLoading: true);
    try {
      final response = await chatRepository.sendQuery(
        message,
      );
      if (response != null) {
        final message = response.message;
        final data = response.businessData;
        //Add AI response to list
        _messages.add(Message(
            isUser: false,
            message: message,
            type: ChatMessageType.text,
            businessData: data
        ));

        state = state.copyWith(messages: _messages, isLoading: false);
      }
    } catch (e) {
      final errorMessage = catchError(e);
      state = state.copyWith(
          messages: _messages, isLoading: false, errorMessage: errorMessage);
    }
  }

}

final chatRepositoryProvider = Provider((_) => ChatRepository(AiService()));

final chatStateProvider = StateNotifierProvider<ChatStateNotifier, ChatState>(
    (ref) => ChatStateNotifier(
        chatRepository: ref.watch(chatRepositoryProvider),
         ));
