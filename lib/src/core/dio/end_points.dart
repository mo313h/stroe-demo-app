import 'package:flutter/foundation.dart';

abstract class EndPoints {
  // Base URL
  static const String productionBaseUrl = "https://dummyjson.com";
  static const String testBaseUrl = "https://dummyjson.com";

  static const String baseUrl = kDebugMode ? testBaseUrl : productionBaseUrl;

  static const String login = '/auth/login';
  static const String products = '/products';
}
