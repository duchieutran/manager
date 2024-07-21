import 'package:appdemo/global/api/api_error.dart';
import 'package:dio/dio.dart';

class RestApi {
  late Dio _dio;
  final String jsonContentType = 'application/json ; charset=UTF-8';
  RestApi(String baseUrl) {
    final BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        contentType: jsonContentType);
    _dio = Dio(options);
  }

  Future<dynamic> get(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async {
    try {
      Response response = await _dio.get(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async {
    try {
      Response response = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async {
    try {
      Response response = await _dio.put(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
    try {
      Response response = await _dio.patch(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  ApiError _apiError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiError(
              errorCode: 'CONNECTION_TIMEOUT',
              errorMessage: 'Qua han ket noi !');
        case DioExceptionType.receiveTimeout:
          return ApiError(
              errorCode: "RECEIVE_TIMEOUT",
              errorMessage: 'Qua han nhan du lieu');
        case DioExceptionType.sendTimeout:
          return ApiError(
              errorCode: "SEND_TIMEOUT", errorMessage: 'Qua han nhan du lieu');
        case DioExceptionType.connectionError:
          return ApiError(
              errorCode: "CONNECTION_ERROR",
              errorMessage: 'Qua han nhan du lieu');
        case DioExceptionType.badResponse:
          if (error.response?.data != null && error.response is Map) {
            String code = "";
            try {
              dynamic e = error.response!.data;
              code = e['code'];
              if (code == '404') {
                return ApiError(
                    errorCode: code,
                    errorMessage: 'Da co loi xay ra',
                    extraData: error.response?.data);
              }
            } catch (e) {
              return ApiError(errorCode: code, errorMessage: 'Co loi xay ra');
            }
          } else {
            return ApiError(errorCode: '404', errorMessage: 'Co loi xay ra');
          }
        default:
        
      }
    }
    return ApiError(errorCode: error);
  }
}
