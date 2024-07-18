import 'package:appdemo/global/api/api_error.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RestClient {
  static const jsonContentType = 'application/json; charset=UTF-8';
  late Dio _dio;
  RestClient({required String baseURL}) {
    final BaseOptions _option = BaseOptions(
        // la url chung cua restAPI
        baseUrl: baseURL,
        // thoi gian toi da ket noi den sever
        connectTimeout: const Duration(seconds: 5),
        // thoi gian doi da nhan respon tu sever
        receiveTimeout: const Duration(seconds: 5),
        // kieu tra ve cua response
        contentType: jsonContentType);
    // khoi tao dio voi option cho toan project
    _dio = Dio(_option);

    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: false,
      responseHeader: false,
      responseBody: true,
      error: true,
      maxWidth: 90,
      compact: true,
    ));
  }

  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> _response = await _dio.get(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return _response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> _response = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return _response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> _response = await _dio.put(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return _response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> _response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final Response<dynamic> _response = await _dio.patch(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return _response.data;
    } catch (e) {
      throw _mapError(e);
    }
  }

  ApiError _mapError(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return ApiError(
              errorCode: "CONNECT_TIMEOUT",
              errorMessege: "Co loi ket noi den sever");
        case DioExceptionType.sendTimeout:
          return ApiError(
              errorCode: "SEND_TIMEOUT",
              errorMessege: "Co loi khi gui den sever");
        case DioExceptionType.receiveTimeout:
          return ApiError(
              errorCode: "RECEIVE_TIMEOUT", errorMessege: "Co loi receive");
        case DioExceptionType.badResponse:
          if (e.response?.data != null && e.response is Map) {
            String code = '';
            try {
              dynamic errorData = e.response!.data;
              code = errorData['code'];
              if (code == '404') {
                return ApiError(
                    errorCode: code,
                    errorMessege: 'Co loi 404 ket noi den sever',
                    extraData: e.response?.data);
              }
            } catch (error) {
              return ApiError(
                  errorMessege: "Co loi da xay ra",
                  extraData: e.response?.data,
                  errorCode: code);
            }
          } else {
            return ApiError(
                errorMessege: "Co loi da xay ra",
                extraData: e.response?.data,
                errorCode: '40444444');
          }
          return ApiError(
              errorCode: "RECEIVE_TIMEOUT", errorMessege: "Co loi receive");

        default:
      }
    }
    return ApiError(extraData: e);
  }
}
