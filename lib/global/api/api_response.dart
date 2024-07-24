class ApiResponse {
  int statusCode;
  String errorCode;
  String errorField;
  String errorMessage;
  dynamic data;

  ApiResponse.fromMap(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int,
        errorCode = json['errorCode'] as String,
        errorField = json['errorField'] as String,
        errorMessage = json['errorMessage'] as String,
        data = json['data'];
}
