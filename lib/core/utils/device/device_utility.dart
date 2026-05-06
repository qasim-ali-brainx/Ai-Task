import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeviceUtility {
  const DeviceUtility._();

  static Size screenSize(BuildContext context) => MediaQuery.sizeOf(context);

  static bool isSmallDevice(BuildContext context) => screenSize(context).width < 360;

  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  static bool get isIos => defaultTargetPlatform == TargetPlatform.iOS;
}
