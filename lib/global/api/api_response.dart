class ApiResponse {
  final int statusCode;
  final String errorCode;
  final String errorMessage;
  final String errorField;
  final dynamic data;
  ApiResponse.fromJSON(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int,
        errorCode = json['errorCode'] as String,
        errorMessage = json['errorMessage'] as String,
        errorField = json['errorField'] as String,
        data = json['data'];
}
