import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  //navigating to the next screen
  void navigateToNextPage(Widget page,
      {Transition? transition, Duration? duration}) {
    Get.to(
      () => page,
      transition: transition ?? Transition.cupertino,
      duration: duration ??
          const Duration(
              milliseconds: 300), // Use 300ms as the default duration
    );
  }

// Goback
  void navigateToPreious() {
    Get.back();
  }
}
