import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class DesmosPlatform {
  static bool get isMobile {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isAndroid || Platform.isIOS;
    }
  }
}
