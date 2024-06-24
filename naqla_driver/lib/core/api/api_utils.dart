import 'dart:async';
import 'dart:io';

import 'dart:developer';
import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'exceptions.dart';

Future<T> throwAppException<T>(FutureOr<T> Function() call) async {
  try {
    return (await call());
  } on AppException catch (_) {
    print('failure is app exception');
    rethrow;
  } on SocketException catch (e) {
    showMessage(e.message);
    throw AppNetworkException(reason: AppNetworkExceptionReason.noInternet, exception: e, message: e.message);
  } on Exception catch (e) {
    throw AppException.unknown(message: e.toString(), exception: e);
  } catch (e, s) {
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

FutureResult<T> toApiResult<T>(FutureOr<T> Function() call) async {
  try {
    return Right(await call());
  } on AppNetworkResponseException catch (e) {
    if (e.data is! String) {
      return Left(e);
    }
    return Left(e);
  } on AppNetworkException catch (e) {
    final message = e.message;
    final appNetworkException = e.copyWith(message: message);
    return Left(appNetworkException);
  } on AppException catch (e) {
    return Left(e);
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    final exception = AppException.unknown(exception: e, message: e.toString());
    return Left(exception);
  }
}
