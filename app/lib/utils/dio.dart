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
  String baseUrl = 'api-game-hunter.vercel.app';
  String protocol = 'https://';

  return dio(ref, baseUrl: '$protocol$baseUrl');
}

@Riverpod(keepAlive: true)
Dio webhookDio(
  Ref ref, {
  bool isTest = false,
}) {
  String baseUrl = 'localhost:5678/webhook';
  String protocol = 'http://';

  if (isTest) {
    baseUrl += '-test';
  }

  return dio(ref, baseUrl: '$protocol$baseUrl');
}

@Riverpod(keepAlive: true)
Dio githubDio(Ref ref) {
  return dio(ref, baseUrl: 'https://api.github.com');
}
