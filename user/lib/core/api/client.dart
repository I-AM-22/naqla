import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:user/core/api/client_config.dart';
import 'package:user/core/api/exceptions.dart';

typedef HttpLibraryMethodInvocation<T> = Future<Response<T>> Function();

@injectable
class ClientApi {
  final Dio _client;
  ClientApi(this._client);

  Future<Response<T>> request<T>(RequestConfig<T> requestConfig,
      {final ProgressCallback? onReceiveProgress,
      final ProgressCallback? onSendProgress}) async {
    Response<T> response;
    final queryParam = requestConfig.queryParameters;
    final data = requestConfig.data;
    final endPoint = requestConfig.endpoint;

    final baseUrl = Uri.parse(_client.options.baseUrl);

    final requestUrl = Uri(
        path: baseUrl.path + endPoint,
        queryParameters: queryParam,
        host: baseUrl.host,
        port: baseUrl.port,
        scheme: baseUrl.scheme);
    switch (requestConfig.clientMethod) {
      case ClientMethod.get:
        function() => _client.getUri<T>(requestUrl,
            onReceiveProgress: onReceiveProgress, data: data);
        response = await _mapException<T>(function);
        break;
      case ClientMethod.post:
        function() => _client.postUri<T>(requestUrl,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
            data: data);
        response = await _mapException<T>(function);
        break;
      case ClientMethod.delete:
        function() => _client.deleteUri<T>(requestUrl, data: data);
        response = await _mapException<T>(function);
        break;
      case ClientMethod.patch:
        function() => _client.patchUri<T>(requestUrl,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
            data: data);
        response = await _mapException<T>(function);
        break;
    }
    return response;
  }

  Future<Response<T>> _mapException<T>(
      HttpLibraryMethodInvocation<T> method) async {
    try {
      return await method();
    } on DioException catch (exception) {
      if (exception.response?.statusCode.toString().matchAsPrefix('5') !=
          null) {
        throw AppNetworkException(
            reason: AppNetworkExceptionReason.serverError,
            exception: exception);
      }
      switch (exception.type) {
        case DioExceptionType.cancel:
          throw AppNetworkException(
            reason: AppNetworkExceptionReason.canceled,
            exception: exception,
          );
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          throw AppNetworkException(
              reason: AppNetworkExceptionReason.timedOut, exception: exception);
        case DioExceptionType.badResponse:
          // For DioErrorType.response, we are guaranteed to have a
          // response object present on the exception.
          final response = exception.response;
          if (response == null || response is! Response<T>) {
            // This should never happen, judging by the current source code
            // for Dio.
            throw AppNetworkResponseException(exception: exception);
          }

          throw AppNetworkResponseException(
            exception: exception,
            statusCode: response.statusCode,
            data: response.data,
          );
        case DioExceptionType.unknown:
        default:
          if (exception.error is SocketException) {
            throw AppNetworkException(
                reason: AppNetworkExceptionReason.noInternet,
                exception: exception);
          }
          throw AppException.unknown(
              exception: exception,
              message: _mapResponseError(exception.response!.data));
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      throw AppException.unknown(
        exception: e is Exception ? e : Exception('Unknown exception occurred'),
        message: "UnKnow Error!",
      );
    }
  }
}

String _mapResponseError(Response response) {
  switch (response.data['type']) {
    case 'default':
      return response.data['message'];
    case 'form':
      return response.data['errors'][0]['message'];
    default:
      return 'SERVER FAILURE';
  }
}
