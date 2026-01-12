import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/app_exception.dart';
import 'logger.dart';

Future<T> catchException<T>(Future<T> Function() func) async {
  AppException? exception;
  StackTrace? stackTrace;
  try {
    return await func();
  } on DioException catch (e, s) {
    exception = handleDioException(e);
    stackTrace = s;
  } catch (e, s) {
    exception = AppException('An unexpected error occurred');
    stackTrace = s;
  }

  appLogger.e('Exception: ${exception.message}', error: exception, stackTrace: stackTrace);

  throw exception;
}

AppException handleDioException(DioException e) {
  AppException exception;
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      exception = AppException(
        'The server took too long to respond',
        code: 504,
        type: 'connection-timeout',
      );
      break;
    case DioExceptionType.badResponse:
      final res = e.response;
      String message = "An unexpected error occurred";
      if (res?.statusCode == 401) {
        message = "You are not authorized to perform this action";
      } else if (res?.statusCode == 404 || res?.statusCode == 409) {
        message = "The resource you are trying to access does not exist";
      } else {
        final data = res?.data;
        // Could be from our webhook and not in json but in string
        if (res?.data is String) {
          try {
            final data = jsonDecode(res?.data);
            if (data['message'] case String messageFromServer) {
              message = messageFromServer;
            } else if (data['error'] case String reasonFromServer) {
              message = reasonFromServer;
            }
          } catch (e) {
            appLogger.w('Could not parse response data ${res?.data}');
          }
        } else if (data is Map<String, dynamic>) {
          if (data['message'] case String messageFromServer) {
            message = messageFromServer;
          }
          if (data['detail'] case Map<String, dynamic> detail) {
            if (detail['message'] case String messageFromServer) {
              message = messageFromServer;
            }
          }
          if (data['detail'] case String messageFromServer) {
            message = messageFromServer;
          }
        }
      }

      Map<String, dynamic>? detail;
      if (e.response?.data is Map<String, dynamic>) {
        detail = e.response?.data;
      } else if (e.response?.data is String) {
        try {
          detail = jsonDecode(e.response?.data);
        } catch (_) {
          appLogger.w('Could not parse response data ${e.response?.data}');
        }
      }

      exception = AppException(
        message,
        code: e.response?.statusCode,
        type: 'bad-response',
        detail: detail,
      );
      break;
    case DioExceptionType.cancel:
      exception = AppException(
        'Request was canceled',
        code: 499,
        type: 'cancel',
      );
      break;
    case DioExceptionType.badCertificate:
      exception = AppException(
        'The server certificate is not trusted',
        code: 500,
        type: 'bad-certificate',
      );
      break;
    case DioExceptionType.unknown:
      exception = AppException(
        'An unknown error occurred',
        code: 500,
        type: 'unknown',
      );
    case DioExceptionType.connectionError:
      exception = AppException(
        'We could not connect to the server, maybe its an internet connection issue',
        code: 500,
        type: 'connection-error',
      );
      break;
  }

  return exception;
}
