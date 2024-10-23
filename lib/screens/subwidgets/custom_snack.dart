import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomGetSnackBar({
  required String message,
  required IconData icon,
  required Color backgroundColor,
  Duration duration = const Duration(seconds: 1),
  Color textColor = Colors.white,
}) {
  Get.snackbar(
    '', // No title needed
    message,
    icon: Icon(
      icon,
      color: textColor,
    ),
    backgroundColor: backgroundColor,
    colorText: textColor,
    duration: duration,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(10),
    borderRadius: 8,
    isDismissible: true,
    snackStyle: SnackStyle.FLOATING,
  );
}
