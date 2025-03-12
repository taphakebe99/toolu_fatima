import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// The `MyDeviceUtility` class provides utility methods to manage device and UI settings,
/// detect device attributes, interact with the system, and perform device-specific functions.
class MyDeviceUtility {
  /// Hides the keyboard if it is currently visible.
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// Sets the color of the status bar to the specified [color].
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }

  /// Returns `true` if the device is in landscape orientation, based on view insets.
  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  /// Returns `true` if the device is in portrait orientation, based on view insets.
  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  /// Enables or disables full-screen immersive mode based on the [enable] parameter.
  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  /// Gets the screen height of the device.
  static double getScreenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  /// Gets the screen width of the device.
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Gets the device's pixel ratio (density).
  static double getPixelRatio() {
    return MediaQuery.of(Get.context!).devicePixelRatio;
  }

  /// Retrieves the height of the device's status bar.
  static double getStatusBarHeight() {
    return MediaQuery.of(Get.context!).padding.top;
  }

  /// Gets the default height of the bottom navigation bar.
  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  /// Gets the default height of the app bar.
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  /// Retrieves the height of the visible keyboard.
  static double getKeyboardHeight() {
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    return viewInsets.bottom;
  }

  /// Checks if the keyboard is currently visible, returning `true` if so.
  static Future<bool> isKeyboardVisible() async {
    final viewInsets = View.of(Get.context!).viewInsets;
    return viewInsets.bottom > 0;
  }

  /// Determines if the app is running on a physical device (not a simulator).
  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  /// Vibrates the device for a specified [duration].
  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  /// Sets the preferred device orientations based on the provided [orientations].
  static Future<void> setPreferredOrientations(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  /// Hides the status bar.
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  /// Checks for an active internet connection by attempting to reach a test URL.
  /// Returns `true` if the device is connected to the internet.
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Checks if the device is running on iOS.
  static bool isIOS() {
    return Platform.isIOS;
  }

  /// Checks if the device is running on Android.
  static bool isAndroid() {
    return Platform.isAndroid;
  }

  /// Attempts to launch a URL in the default browser. Throws an error if unsuccessful.
  static void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
