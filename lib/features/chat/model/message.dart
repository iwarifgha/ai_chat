import '../../../core/enums/chat_messag_type.dart';
import 'business_in_chat.dart';

class Message {
  final String? fileUrl;
  final String? audioPath;
  final ChatMessageType type;
  final String? avatarUrl;
  final bool isUser;
  final String message;
  final List<BusinessInChat> businessData;

  Message(
      {this.fileUrl,
      this.audioPath,
      this.avatarUrl,
      required this.type,
        required this.businessData,
      required this.isUser,
      required this.message});

  Map<String, dynamic> toJson() {
    return {
      'text': message,
      'is_user': isUser,
      'file_url': fileUrl,
      'avatar': avatarUrl
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    final jsonList = json['data'] as List<dynamic>;
    final businessData = jsonList.map((item) => BusinessInChat.fromJson(item)).toList();
    return Message(
        message: json['message'],
        isUser: false,
        avatarUrl: null,
        fileUrl: null,
        type: ChatMessageType.text,
        businessData: businessData
        );
  }
}
