import 'dart:convert';

import 'package:dio/dio.dart';

class HelperFunctions {
  static String getCurlCommandFromRequest(RequestOptions requestOptions) {
    var curlCmd = "curl";
    curlCmd += " -X ${requestOptions.method}";
    curlCmd += " \"${requestOptions.baseUrl}${requestOptions.uri.path}\"";

    // Adding headers to the command
    requestOptions.headers.forEach((key, value) {
      curlCmd += " -H \"$key: $value\"";
    });

    // Adding requestOptions body to the command for non-multipart requests
    if (requestOptions.data != null && requestOptions.data is! FormData) {
      curlCmd += " -d '${json.encode(requestOptions.data)}'";
    }

    return curlCmd;
  }
}
