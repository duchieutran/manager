import 'package:appdemo/global/api/api_response.dart';

class ApiError {
  final String? errorCode;
  final String? errorMessege;
  final dynamic extraData;

  ApiError({this.errorCode, this.errorMessege, this.extraData});

  ApiError.fromResponse(ApiResponse response)
      : errorCode = response.errorCode,
        errorMessege = response.message,
        extraData = response.data;
}
