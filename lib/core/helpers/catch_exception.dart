import 'dart:io';

import 'package:ai_chat/core/components/exceptions/exceptions.dart';

T catchException<T>(T Function() action){
  try {
    return action();
  } on SocketException {
     throw NoInternetException();
  } on HttpException {
    throw SomethingWentWrongException();
  } on FormatException{
    throw BadResponseException();
  } catch (e) {
   throw GeneralErrorException(message: 'Unexpected error: ${e.toString}');
  }
}

