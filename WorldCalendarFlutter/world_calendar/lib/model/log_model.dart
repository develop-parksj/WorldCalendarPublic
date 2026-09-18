import 'package:flutter/foundation.dart';

class LogModel {
  static final LogModel _model = LogModel();
  static LogModel get instance => _model;

  LogModel();

  void print(String message, {StackTrace? stackTrace}) {
    if (kDebugMode) {
      if (stackTrace != null) {
        debugPrintStack(stackTrace: stackTrace, label: message);
      } else {
        debugPrint(message);
      }
    }
  }
}