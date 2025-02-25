import 'package:ai_chat/core/helpers/catch_exception.dart';
import 'package:ai_chat/core/services/ai_service.dart';
import 'package:ai_chat/features/chat/model/message.dart';

class ChatRepository{
  final AiService aiService;
  ChatRepository(this.aiService);

  Future<Message?> sendQuery(String query) async {
    return catchException(() async {
      final message = await aiService.sendAQuery(query);
      return message;
    });
  }
}