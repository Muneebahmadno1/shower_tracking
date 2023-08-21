class ApiExceptions implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  ApiExceptions([this.message, this.prefix, this.url]);
}

class BadRequestException extends ApiExceptions {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad Request', url);
}

class FetchDataException extends ApiExceptions {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends ApiExceptions {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responded in time', url);
}

class UnAuthorizedException extends ApiExceptions {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'UnAuthorized request', url);
}
