import 'dart:convert';

import 'package:ai_chat/core/helpers/catch_exception.dart';
import 'package:ai_chat/keys.dart';

import '../../features/chat/model/message.dart';
import '../components/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;


class AiService {
  AiService();

  Future<Message> sendAQuery(String message) async {
    final url = Uri.parse('$baseUrl/chatter-ai/chat/');
    return catchException( () async {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $bearerToken',
            'X-CSRFTOKEN':
            'NVoIIbv9haZR1EIMDgJ5XySue8nhBeAnrSGhFYHatQD9zXa3rxC8ll996e95wWv7'
          },
          body: jsonEncode({'input': message}));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final aiMessage = Message.fromJson(data);
        print('Ai message',);
        return aiMessage;
      } else {
        throw SomethingWentWrongException();
      }
    });
  }

}