import '../../../core/enums/chat_messag_type.dart';

class Message {
  final String? fileUrl;
  final String? audioPath;
  final ChatMessageType type;
  final String? avatarUrl;
  final bool isUser;
  final String message;

  Message(
      {this.fileUrl,
      this.audioPath,
      this.avatarUrl,
      required this.type,
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
    return Message(
        message: json['text'],
        isUser: json['is_user'],
        avatarUrl: json['avatar_url'],
        fileUrl: json['file_url'],
        type: json['type'] //Flag: incorrect programming
        );
  }
}
