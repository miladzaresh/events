class CustomException implements Exception {
  final String _message;
  final String _prefix;

  const CustomException([this._message = "", this._prefix = ""]);
  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  const FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  const BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  const UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  const InvalidInputException([message]) : super(message, "Invalid Input: ");
}
