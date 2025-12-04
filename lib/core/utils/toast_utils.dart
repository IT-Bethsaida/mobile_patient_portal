import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Utility class untuk menampilkan toast messages
class ToastUtils {
  /// Show success toast (green background)
  static void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show error toast (red background)
  static void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red.withValues(alpha: 0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show info toast (blue background)
  static void showInfo(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue.withValues(alpha: 0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show warning toast (orange background)
  static void showWarning(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.orange.withValues(alpha: 0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show default toast (grey background with transparency)
  static void showDefault(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey.withValues(alpha: 0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show custom toast with custom parameters
  static void showCustom({
    required String message,
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    double fontSize = 16.0,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  /// Cancel all toasts
  static void cancel() {
    Fluttertoast.cancel();
  }
}
