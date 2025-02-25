class NoInternetException implements Exception{}
class SomethingWentWrongException implements Exception{}
class BadResponseException implements Exception{}
class UnexpectedErrorException implements Exception{}
class GeneralErrorException implements Exception{
  final String message;
  GeneralErrorException({required this.message});
}