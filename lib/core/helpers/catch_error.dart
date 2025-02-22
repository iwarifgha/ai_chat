import 'package:flutter/foundation.dart';

import '../components/exceptions/exceptions.dart';

String catchError(dynamic error) {
  if (error is NoInternetException) {
    return ' You have no Internet connection ';
  } else if (error is SomethingWentWrongException) {
    return  ' Something went wrong. Please try again ';
  } else if (error is BadResponseException) {
    return  ' Incorrect input. Please check and try again ';
  } else {
    if (kDebugMode) {
      print(error.toString());
    }
    return 'Unexpected error: Please try again. ';
  }
}