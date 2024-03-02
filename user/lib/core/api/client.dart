import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'exceptions.dart';

/// A callback that returns a Dio response, presumably from a Dio method
/// it has called which performs an HTTP request, such as `dio.get()`,
/// `dio.post()`, etc.
typedef HttpLibraryMethod<T> = Future<Response<T>> Function();

/// Function which takes a Dio response object and optionally maps it to an
/// instance of [AppHttpClientException].
typedef ResponseExceptionMapper = AppException? Function(
    Response response, Exception e);

class DioClient with DioMixin implements Dio {
  ///this is locale for testing purpose
  DioClient({required this.baseUrl, List<Interceptor>? interceptors}) {
    httpClientAdapter = IOHttpClientAdapter();
    options = BaseOptions();
    options
      ..baseUrl = baseUrl
      ..headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'lang': "en",
      };
    if (interceptors != null) {
      this.interceptors.addAll([...interceptors, LogInterceptor()]);
    }
  }

  final String baseUrl;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _mapException(
      () => super.get(
        path,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        data: data,
      ),
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    ResponseExceptionMapper? exceptionMapper,
  }) {
    return _mapException(
      () => super.post(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    ResponseExceptionMapper? exceptionMapper,
  }) {
    return _mapException(
      () => super.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ResponseExceptionMapper? exceptionMapper,
  }) {
    return _mapException(
      () => super.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response<T>> _mapException<T>(
    HttpLibraryMethod<T> method, {
    ResponseExceptionMapper? mapper,
  }) async {
    try {
      ///add your function
      return await method();
    } on DioException catch (exception) {
      if (exception.response?.statusCode.toString().matchAsPrefix('5') !=
          null) {
        throw AppNetworkException(
            reason: AppNetworkExceptionReason.serverError,
            exception: exception,
            message: handleMessage(exception.response?.data));
      }
      switch (exception.type) {
        case DioExceptionType.cancel:
          throw AppNetworkException(
              reason: AppNetworkExceptionReason.canceled,
              exception: exception,
              message: handleMessage(exception.response?.data));
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          throw AppNetworkException(
              reason: AppNetworkExceptionReason.timedOut,
              exception: exception,
              message: handleMessage(exception.response?.data));
        case DioExceptionType.badResponse:
          // For DioErrorType.response, we are guaranteed to have a
          // response object present on the exception.
          final response = exception.response;
          if (response == null || response is! Response<T>) {
            // This should never happen, judging by the current source code
            // for Dio.
            throw AppNetworkResponseException(
                exception: exception,
                message: handleMessage(exception.response?.data));
          }

          throw mapper?.call(response, exception) ??
              // exceptionMapper?.call(response, exception)
              // ??
              AppNetworkResponseException(
                  exception: exception,
                  statusCode: response.statusCode,
                  data: response.data,
                  message: handleMessage(exception.response?.data));
        case DioExceptionType.unknown:
        default:
          if (exception.error is SocketException) {
            throw AppNetworkException(
                reason: AppNetworkExceptionReason.noInternet,
                message: handleMessage(exception.response?.data),
                exception: exception);
          }
          throw AppException.unknown(
              exception: exception,
              message: handleMessage(exception.response?.data));
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      throw AppException.unknown(
          exception:
              e is Exception ? e : Exception('Unknown exception occurred'),
          message: e.toString());
    }
  }

  String handleMessage(dynamic exceptionResponse) =>
      (exceptionResponse is Map && exceptionResponse['message'] != null)
          ? (exceptionResponse['message'] ??
              exceptionResponse['errors'][0]['message'] ??
              " Some thing happen")
          : 'Something happen '; //todo click to submit error
}

String addBearer(String hh) => 'Bearer $hh';
