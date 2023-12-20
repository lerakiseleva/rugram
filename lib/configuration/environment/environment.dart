import 'package:dio/dio.dart';

class Environment {
  static final BaseOptions baseDioOptions = BaseOptions(
    baseUrl: 'https://dummyapi.io/data/v1/',
    headers: {
      'app-id': '6572030a07d4322c97120231',
    },
  );
}
