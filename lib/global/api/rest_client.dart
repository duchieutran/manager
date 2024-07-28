import 'package:appdemo/global/api/api_error.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RestClient {
  late Dio _dio;
  static const jsonContentType = 'application/json ; charset=UTF-8';
  RestClient(String baseUrl) {
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
      contentType: jsonContentType,
    );
    _dio = Dio(options);
    // intercepter => PrettyDioLogger
    _dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 180,
    ));
  }

  // get
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response<dynamic> response = await _dio.get(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  // post
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response<dynamic> response = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (e) {
      return _mapError(e);
    }
  }

  // put
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response<dynamic> response = await _dio.put(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (e) {
      return _mapError(e);
    }
  }

  // patch
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response<dynamic> response = await _dio.patch(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (e) {
      return _mapError(e);
    }
  }

  // delete
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response<dynamic> response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      return _mapError(e);
    }
  }

  // api_error
  ApiError _mapError(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return ApiError(
              errorCode: 'ConnectTimeout',
              errorMessage: 'Lỗi quá hạn kết nối !');
        case DioExceptionType.sendTimeout:
          return ApiError(
              errorCode: 'SendTimeout', errorMessage: 'Lỗi quá hạn gửi !');
        case DioExceptionType.receiveTimeout:
          return ApiError(
              errorCode: 'RêciveTimeout',
              errorMessage: 'Lỗi quá hạn nhận dữ liệu !');
        case DioExceptionType.badResponse:
          if (e.response?.data != null && e.response?.data is Map) {
            String code = '';
            try {
              // vì bên trên kiểm check null rồi nên bên dưới mới được sử dụng
              dynamic error = e.response!.data;
              code = error['code'];
              if (code == '404') {
                return ApiError(
                    errorCode: code,
                    errorMessage:
                        'Không tin thấy trang hoặc tài nguyên yêu cầu !');
              }
            } catch (err) {
              return ApiError(
                  errorCode: code,
                  errorMessage: 'Lỗi không rõ định dạng !',
                  extraData: err);
            }
          } else {
            return ApiError(
                errorCode: '401',
                errorMessage: 'Lỗi không rõ định dạng !',
                extraData: e.response!.data);
          }

        default:
          return ApiError(
            errorCode: '=))) ???',
            errorMessage: 'Lỗi dì vậy má =)))) !',
          );
      }
    }
    return ApiError(extraData: e);
  }
}
