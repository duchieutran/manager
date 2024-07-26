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
        connectTimeout: const Duration(minutes: 20),
        // thoi gian doi da nhan respon tu sever
        receiveTimeout: const Duration(seconds: 5),
        // kieu tra ve cua response
        contentType: jsonContentType);
    // khoi tao dio voi option cho toan project
    _dio = Dio(_option);

    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      maxWidth: 180,
      compact: true,
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Do something before request is sent.
          // If you want to resolve the request with custom data,
          // you can resolve a `Response` using `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject with a `DioException` using `handler.reject(dioError)`.
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // Do something with response data.
          // If you want to reject the request with a error message,
          // you can reject a `DioException` object using `handler.reject(dioError)`.
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          // Do something with response error.
          // If you want to resolve the request with some custom data,
          // you can resolve a `Response` object using `handler.resolve(response)`.
          print('hello Hieu $error');
          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
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
              errorMessage: "Hết hạn kết nối đến sever !");
        case DioExceptionType.sendTimeout:
          return ApiError(
              errorCode: "SEND_TIMEOUT",
              errorMessage: "Thời gian gửi hết hạn !");
        case DioExceptionType.receiveTimeout:
          return ApiError(
              errorCode: "RECEIVE_TIMEOUT",
              errorMessage: "Lỗi kết nối recerive time !");
        case DioExceptionType.badResponse:
          if (e.response?.data != null && e.response is Map) {
            String code = '';
            try {
              dynamic errorData = e.response!.data;
              code = errorData['code'];
              if (code == '404') {
                return ApiError(
                    errorCode: code,
                    errorMessage: 'Co loi 404 ket noi den sever',
                    extraData: e.response?.data);
              }
            } catch (error) {
              return ApiError(
                  errorMessage: "Co loi da xay ra",
                  extraData: e.response?.data,
                  errorCode: code);
            }
          } else {
            return ApiError(
                errorMessage: "An error has occurred.",
                extraData: e.response?.data,
                errorCode: '4000');
          }
          return ApiError(
              errorCode: "RECEIVE_TIMEOUT", errorMessage: "Co loi receive");

        default:
      }
    }
    return ApiError(extraData: e);
  }
}
