import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

abstract final class ErrorHandler {
  static String getMessage(Object? error) {
    log('error $error');
    String errorMessage = 'Oops! Something went wrong.';
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.connectionError:
            errorMessage = "No internet connection!";
          case DioExceptionType.badResponse:
            if (error.response!.statusCode! > 500) {
              errorMessage =
                  "We’re having trouble completing your request right now. Please try again later.";
            } else {
              errorMessage = error.response?.data['message'] ?? errorMessage;
            }
          case DioExceptionType.unknown:
            errorMessage = errorMessage;
          case DioExceptionType.connectionTimeout ||
                DioExceptionType.sendTimeout ||
                DioExceptionType.receiveTimeout:
            errorMessage = "Check your internet connection.";
          default:
            errorMessage = errorMessage;
        }
      } else if (error is TypeError) {
        return 'Type error';
      } else if (error is SocketException) {
        return 'Check your internet connection!';
      } else {
        return errorMessage;
      }
    } catch (e) {
      log('catch error $e');
      return errorMessage;
    }
    return errorMessage;
  }
}
