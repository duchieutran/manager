class ApiResponse {
  int statusCode;
  String errorCode;
  String errorMessage;
  String errorField;
  dynamic data;

  ApiResponse.fromJSON(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int,
        errorCode = json['errorCode'] as String,
        errorMessage = json['errorMessage'] as String,
        errorField = json['errorField'] as String,
        data = json['data'];
}
