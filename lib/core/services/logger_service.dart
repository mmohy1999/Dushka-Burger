import 'dart:developer';
import 'package:flutter/foundation.dart';
class LoggerService {
  LoggerService._();
  static void logInfo(String message) {
    if (kDebugMode) {
      log(message);
    }
  }

  static void logWarning(String message) {
    if (kDebugMode) {
      log('WARNING: $message');
    }
  }

  static void logError(String message) {
    if (kDebugMode) {
      log('ERROR: $message');
    }
  }
}