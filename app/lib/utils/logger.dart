import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final Logger appLogger = Logger(printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5, lineLength: 80));

class PrettyDioLogger extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    appLogger.f('''❌ Dio Error!
      ❌ Url: ${err.requestOptions.uri}
      ❌ Method: ${err.requestOptions.method}
      ❌ Status Code: ${err.response?.statusCode}
      ❌ Response Error: ${err.response?.data}
      ❌ Stack Trace: ${err.stackTrace}
      ''');
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    appLogger.i(
      '🌍 Sending network request: ${options.baseUrl}${options.path}\nHTTP Method: [${options.method}]\nPayload: ${options.data}',
    );
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    appLogger.i('''⬅️ Received network response
      ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}
      Query params: ${response.requestOptions.queryParameters}
      ✅Response: ${response.data}
      ''');
    return handler.next(response);
  }
}
