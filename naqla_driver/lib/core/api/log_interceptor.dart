import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import '../../features/app/domain/repository/prefs_repository.dart';
import '../common/enums/status_code_type.dart';
import 'api_utils.dart';

enum _StatusType {
  succeed,
  failed,
}

class DioLogInterceptor extends Interceptor {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  final Logger logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (getIt<PrefsRepository>().registeredUser) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer ${GetIt.I<PrefsRepository>().token}';
    }
    if (kDebugMode) {
      logger.i("***|| INFO Request ${options.method} ${options.path} ||***"
          "\n param : ${options.queryParameters}"
          "\n data : ${options.data}"
          "\n authorization: ${encoder.convert(options.headers["authorization"])}");
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      _StatusType statusType;
      if (response.statusCode == StatusCode.operationSucceeded.code ||
          response.statusCode == StatusCode.operationCreated.code ||
          response.statusCode == StatusCode.noContent.code) {
        statusType = _StatusType.succeed;
      } else {
        statusType = _StatusType.failed;
      }

      if (statusType == _StatusType.failed) {
        logger.e('***|| ${statusType.name.toUpperCase()} Response into -> ${response.requestOptions.uri.path} ||***');
      } else {
        logger.t('***|| ${statusType.name.toUpperCase()} Response into -> ${response.requestOptions.uri.path} ||***');
      }

      logger.f(
        "***|| INFO Response Request ${response.requestOptions.uri.path} ${statusType == _StatusType.succeed ? '✊' : ''} ||***"
        "\n Status code: ${response.statusCode}"
        "\n Status message: ${response.statusMessage}"
        "\n Data: ${encoder.convert(response.data)}",
      );
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      print('401');
    }
    if (kDebugMode) {
      logger.e(
        "***|| SOMETHING WENT WRONG 💔 ||***"
        "\n error: ${err.error}"
        "\n response: ${err.response}"
        "\n message: ${err.message}"
        "\n type: ${err.type}"
        "\n stackTrace: ${err.stackTrace}",
      );
    }

    final data = err.response?.data;
    if (data != null && data != "") {
      if (data is Map<String, dynamic>) {
        showMessage(_mapResponseError(data));
      } else {
        showMessage('Something went wrong!!');
      }
    }

    handler.next(err);
  }
}

String _mapResponseError(Map<String, dynamic> response) {
  switch (response['type']) {
    case 'default':
      return response['message'];
    case 'form':
      return response['errors'][0]['message'];
    default:
      return "حصل خطأ ما!!";
  }
}
