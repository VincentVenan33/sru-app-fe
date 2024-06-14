import 'dart:io';

import 'package:flutter/foundation.dart';

class AppConstant {
  static const String androidPlatform = 'android';
  static const String iOSPlatform = 'ios';
  static const String webPlatform = 'web';
  static const String defaultCountryCode = '+62';
  static const String defaultLocale = 'in_ID';

  static const String appSource = 'mjk-app';

  static String? get platform {
    if (kIsWeb) {
      return webPlatform;
    } else if (Platform.isIOS) {
      return iOSPlatform;
    }
    return androidPlatform;
  }
}

enum NotifMessageType {
  deeplink,
  reorderMinimumStock,
}

extension NotifMessageTypeExt on NotifMessageType {
  String get label {
    switch (this) {
      case NotifMessageType.deeplink:
        return 'deeplink';
      case NotifMessageType.reorderMinimumStock:
        return 'reorder_minimum_stock';
    }
  }
}

class NotifMessageTypes {
  static const notifMessageTypes = {
    'deeplink': NotifMessageType.deeplink,
    'reorder_minimum_stock': NotifMessageType.reorderMinimumStock,
  };
}
