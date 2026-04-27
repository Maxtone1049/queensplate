import 'package:flutter/material.dart';

enum AppEnv { development, production }

class AppConfig {
  static late AppEnv _appEnv;

  static void setAppEnv(AppEnv env) => _appEnv = env;

  static bool get _isProduction => _appEnv == AppEnv.production;

  static String get fileName => _isProduction ? '.env' : '.env.development';

  static String get apiUrl => 'https://api.queensplate.store/api/v1/';

  static Iterable<Locale> get locals => const [
    Locale('en'),
    Locale('zh'),
    Locale('ja'),
    Locale('uk'),
    Locale('it'),
    Locale('ru'),
    Locale('fr'),
    Locale('es'),
    Locale('nl'),
    Locale('sv'),
    Locale('pt'),
  ];

  static Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates =>
      [];
}
