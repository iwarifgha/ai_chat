import 'dart:io';

import 'package:ai_chat/core/constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/enums/chat_messag_type.dart';
import 'file_displayer.dart';

class UserBubble extends ConsumerWidget {
  const UserBubble(
      {super.key,

        this.message,
        this.fileUrl,
        required this.avatarUrl,
        required this.type,
        this.audioMessagePath});


  final String? message;
  final String? fileUrl; // List of file URLs (images, videos, etc.)
  final String avatarUrl;
  final ChatMessageType type;
  final String? audioMessagePath; //Path to audio file

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     // Colors based on the message owner
    final bubbleColor =  kColorPrimary;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.end ,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (type == ChatMessageType.text)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: bubbleColor,
              border: Border.all(color: kColorCyanAccent),
                borderRadius: BorderRadius.circular(15),
                  ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Text message
                Flexible(
                  child: Column(
                    children: [
                      if (message != null && message!.isNotEmpty)
                        Text(
                          message!,
                          style: TextStyle(
                            color: kColorWhite
                          ),
                        ),
                      if (fileUrl != null)
                        FileDisplayer(
                          file: File(fileUrl!),
                        ),
                    ],
                  ),
                ),
                //User avatar
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 15,
                   backgroundColor: kColorGrey ,
                ),
              ],
            ),
          ),
        if (type == ChatMessageType.audio)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 3),
                    color: kColorGrey.shade100,
                    blurRadius: 9.4,
                  ),
                ]),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // spacing: 8,
              children: [
                Icon(Icons.play_arrow, color: Colors.black),
                SizedBox(height: 8),
                Text(
                  '$message',
                  style: TextStyle(
                    color: kColorWhite
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
