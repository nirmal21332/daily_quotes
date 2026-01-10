class AppException implements Exception {
  final String _prefix, _suffix;
  AppException(this._prefix, this._suffix);

  @override
  String toString() {
    return '$_prefix$_suffix';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? message)
      : super(message!, 'Error During Data Fetching');
}

class BadRequestException extends AppException {
  BadRequestException(String? message) : super(message!, 'Bad Request');
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String? message) : super(message!, 'Unauthorised');
}

class TimeOutException extends AppException {
  TimeOutException(String? message) : super(message!, 'Time Out');
}
