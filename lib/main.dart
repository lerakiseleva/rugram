import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rugram/core/di/app_services.dart';

import 'configuration/environment/environment.dart';
import 'core/app.dart';
import 'dart:io';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  final appServices = AppServices(
    dio: Dio(Environment.baseDioOptions),
  );

  runZonedGuarded(
    () => runApp(
      MyApp(
        appServices: appServices,
      ),
    ),
    (error, stack) {
      log('$error', stackTrace: stack);
    },
  );
}
