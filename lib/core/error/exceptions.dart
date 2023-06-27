abstract class GenericException implements Exception {
  final String message;

  GenericException(this.message);
}

class GetDataApiException extends GenericException {
  GetDataApiException(String message) : super(message);
}

class NoInternetConnectionException extends GenericException {
  NoInternetConnectionException(String message) : super(message);
}
