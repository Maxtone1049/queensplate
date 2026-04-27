import 'dart:async';

import 'package:flutter/cupertino.dart';

class Debouncer {
  Debouncer();
  static Timer? _timer;

  static void run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), action);
  }
}
