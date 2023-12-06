import 'dart:async';
import 'dart:io';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user/core/api/exceptions.dart';
import 'package:user/core/api/result.dart';

Future<T> throwAppException<T>(FutureOr<T> Function() call) async {
  try {
    return (await call());
  } on AppException catch (e) {
    rethrow;
  } on SocketException catch (e) {
    showMessage(e.message);
    throw AppNetworkException(
        reason: AppNetworkExceptionReason.noInternet,
        exception: e,
        message: e.message);
  } on Exception catch (e) {
    showMessage(e.toString());
    throw AppException.unknown(message: e.toString(), exception: e);
  } catch (e, s) {
    showMessage(e.toString());
    log(e.toString(), stackTrace: s);
    throw AppException.unknown(message: e.toString(), exception: e);
  }
}

void showMessage(String message, {bool isSuccess = false}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: isSuccess ? Colors.greenAccent : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<Result<T>> toApiResult<T>(FutureOr<T> Function() call) async {
  try {
    return Success(await call());
  } on AppNetworkResponseException catch (e) {
    if (e.data is String) {
      return Failure(e, message: e.message);
    }
    return Failure(e, message: e.message);
  } on AppNetworkException catch (e) {
    final message = e.message;
    final appNetworkException = e.copyWith(message: message);
    return Failure(appNetworkException, message: message);
  } on AppException catch (e) {
    return Failure(e, message: e.message);
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    final exception = AppException.unknown(message: e.toString(), exception: e);
    return Failure(exception, message: exception.message);
  }
}
