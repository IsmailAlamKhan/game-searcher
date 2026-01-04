import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'logger.dart';

part 'dio.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref, {String baseUrl = ''}) {
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  dio.interceptors.add(PrettyDioLogger());
  return dio;
}

@Riverpod(keepAlive: true)
Dio engineDio(Ref ref) {
  return dio(ref, baseUrl: 'http://127.0.0.1:5678');
}

@Riverpod(keepAlive: true)
Dio githubDio(Ref ref) {
  return dio(ref, baseUrl: 'https://api.github.com');
}
