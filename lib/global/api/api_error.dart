class ApiError {
  final String? errorCode;
  final String? errorMessage;
  final dynamic extraData;

  ApiError({this.errorCode, this.errorMessage, this.extraData});
}
