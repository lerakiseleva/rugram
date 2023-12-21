import 'package:dio/dio.dart';

class Environment {
  static final BaseOptions baseDioOptions = BaseOptions(
    baseUrl: 'https://dummyapi.io/data/v1/',
    headers: {
      'app-id': '65837c705c3c46f811474f42',
    },
  );
}
