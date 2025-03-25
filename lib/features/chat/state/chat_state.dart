import 'package:ai_chat/core/services/voice_service.dart';
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
  bool isLoading;
  bool isRecording;
  final bool voiceServiceEnabled;
  final String? errorMessage;

  ChatState({
    required this.messages,
    this.isLoading = false,
    this.isRecording = false,
    this.voiceServiceEnabled = false,
    this.errorMessage,
  });

  ChatState copyWith(
      {final List<Message>? messages,
      bool? isLoading,
      String? errorMessage,
      bool? isRecording,
      bool? voiceServiceEnabled}) {
    return ChatState(
        messages: messages ?? this.messages,
        isLoading: isLoading ?? this.isLoading,
        isRecording: isRecording ?? this.isRecording,
        errorMessage: errorMessage,
        voiceServiceEnabled: voiceServiceEnabled ?? this.voiceServiceEnabled);
  }
}

//--------STATE NOTIFIER-------//

class ChatStateNotifier extends StateNotifier<ChatState> {
  final ChatRepository chatRepository;
  final VoiceNoteService voiceNoteService;

  final List<Message> _messages = [];

  ChatStateNotifier(
      {required this.voiceNoteService, required this.chatRepository})
      : super(ChatState(messages: []));


  //SENDS A QUERY TO THE AI
  Future<void> sendRegularQuery({required String message}) async {
    print('sending regular query');
    state = state.copyWith(messages: _messages, isLoading: true);

    //add user message to the list
    _messages.add(Message(
        isUser: true,
        message: message,
        type: ChatMessageType.text,
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
            businessData: data));

        state = state.copyWith(messages: _messages, isLoading: false);
      }
    } catch (e) {
      final errorMessage = catchError(e);
      state = state.copyWith(
          messages: _messages, isLoading: false, errorMessage: errorMessage);
    }
  }

  Future<bool> initializeVoiceService() async {
    try {
      final voiceServiceEnabled =
          await voiceNoteService.initializeVoiceFeature();
      state = state.copyWith(voiceServiceEnabled: voiceServiceEnabled);
      print('voice permission status: $voiceServiceEnabled');
      return voiceServiceEnabled;
    } catch (e) {
      final errorMessage = catchError(e);
      state = state.copyWith(
          errorMessage: errorMessage, voiceServiceEnabled: false);
      return false;
    }
  }

  String _recognizedWords = '';


  Future<void> startVoiceSession() async {
    state = state.copyWith(isRecording: true);
    try {
      //Start voice recorder
      // await voiceNoteService.startRecorder();
      //Start speech listener
      await voiceNoteService.startListening(onResult: (text) async {
        print('recorded text $text');
        _recognizedWords = text;
      });
    } catch (e) {
      final errorMessage = catchError(e);
      state = state.copyWith(errorMessage: errorMessage, isRecording: false);
    }
  }

  Future<void> stopVoiceSessionAndSendQuery() async {
    print('sending regular query');
    await voiceNoteService.stopListening();

    if (_recognizedWords.trim().isEmpty) {
      print('No valid speech detected, ignoring empty message.');
      state = state.copyWith(isRecording: false); // Reset recording state
      return;
    }

    // Store message and reset _recognizedWords immediately
    final userMessage = _recognizedWords;
    _recognizedWords = '';

    //add user message to the list
    _messages.add(Message(
        //audioPath: audioPath,
        isUser: true,
        message: userMessage,
        type: ChatMessageType.text,
        businessData: []));

    state = state.copyWith(
        messages: _messages, isLoading: true, isRecording: false);
    try {
      final response = await chatRepository.sendQuery(
        userMessage,
      );
      if (response != null) {
        final message = response.message;
        final data = response.businessData;
        //Add AI response to local list of messages
        _messages.add(Message(
            isUser: false,
            message: message,
            type: ChatMessageType.text,
            businessData: data));

        state = state.copyWith(messages: _messages, isLoading: false);
      }
    } catch (e) {
      final errorMessage = catchError(e);
      state = state.copyWith(
          messages: _messages, isLoading: false, errorMessage: errorMessage);
    }
  }

  @override
  void dispose() {
    voiceNoteService.disposeRecorder();
    super.dispose();
  }
}

final chatRepositoryProvider = Provider((_) => ChatRepository(AiService()));
final voiceServiceProvider = Provider((_) => VoiceNoteService());

final chatStateProvider = StateNotifierProvider<ChatStateNotifier, ChatState>(
    (ref) => ChatStateNotifier(
          chatRepository: ref.watch(chatRepositoryProvider),
          voiceNoteService: ref.watch(voiceServiceProvider),
        ));
