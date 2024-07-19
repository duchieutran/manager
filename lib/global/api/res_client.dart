import 'package:appdemo/global/api/api_error.dart';
import 'package:dio/dio.dart';

class ResClient {
  late Dio _dio;
  static const jsonContentType = 'application/json ; charset=UTF-8';
  ResClient({required String baseURL}) {
    final options = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        contentType: jsonContentType);
    _dio = Dio(options);
  }

  Future<dynamic> get(String path) async {
    try {
      final Response<dynamic> response = await _dio.get(path);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


  ApiError _mapError(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return ApiError(
            errorCode: 'Oh No !',
            errorMessage: 'Co loi ket noi den sever',
          );
        case DioExceptionType.sendTimeout:
          return ApiError(
            errorCode: 'Oh No !',
            errorMessage: 'Co loi ket noi den sever',
          );
        case DioExceptionType.receiveTimeout:
          return ApiError(
            errorCode: 'Oh No !',
            errorMessage: 'Co loi ket noi den sever',
          );
        case DioExceptionType.badResponse:
          if (e.response?.data != null && e.response?.data is Map) {
            String code = '';
            try {
              dynamic errorData = e.response!.data;
              code = errorData['code'];
              if (code == '404') {
                return ApiError(
                    errorCode: code,
                    errorMessage: 'loi ket noi 404',
                    extraData: errorData);
              }
            } catch (error) {
              return ApiError(
                  errorCode: code,
                  errorMessage: 'Error',
                  extraData: e.response!.data);
            }
          }

        default:
      }
    }
    return ApiError(extraData: e);
  }
}
