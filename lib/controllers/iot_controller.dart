import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:liquid_dispenser/screens/subwidgets/custom_snack.dart';
import 'package:liquid_dispenser/variables.dart';

class IotController extends GetxController {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  var connected = true.obs;
  var ceilinglampon = false.obs;
  var iswallon = false.obs;
  var issecurityon = false.obs;
  var isFanOn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFirebaseListeners();
    _checkInternetConnection();
  }

  void _initializeFirebaseListeners() {
    _dbRef.child('D1').onValue.listen((event) {
      ceilinglampon.value = event.snapshot.value == 'on';
    });
    _dbRef.child('D2').onValue.listen((event) {
      iswallon.value = event.snapshot.value == 'on';
    });
    _dbRef.child('D3').onValue.listen((event) {
      isFanOn.value = event.snapshot.value == 'on';
    });
    _dbRef.child('D4').onValue.listen((event) {
      issecurityon.value = event.snapshot.value == 'on';
    });
  }

  void _checkInternetConnection() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      connected.value = status == InternetConnectionStatus.connected;
      if (!connected.value) {
        _showReconnectingDialog();
      } else {
        _hideReconnectingDialog();
      }
    });
  }

  void _showReconnectingDialog() {
    if (!Get.isDialogOpen!) {
      Get.dialog(
        CupertinoAlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Internet Connection Error",
                style: TextStyle(fontWeight: FontWeight.bold, color: textgreen),
              ),
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(),
              CircularProgressIndicator(
                color: greencolor,
              ),
              const SizedBox(
                width: 9,
              ),
              Text(
                "Reconnecting.......",
                style: TextStyle(fontWeight: FontWeight.bold, color: textgreen),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  void _hideReconnectingDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  // Method to toggle ceiling lamp state
  void toggleSwitch(bool value) {
    if (connected.value) {
      ceilinglampon.value = value;
      _dbRef.child('D1').set(value ? 'on' : 'off');
      showCustomGetSnackBar(
        message:
            value ? "Device1 is ON" : "Device1 is OFF", // Display fan state
        icon: value ? Icons.power : Icons.power_off, // Icon for on/off
        backgroundColor:
            value ? Colors.green : Colors.red, // Green for on, red for off
      );
    } else {
      _showReconnectingDialog();
    }
  }

  // Handle wall switch
  void togglewall(bool value) {
    if (connected.value) {
      iswallon.value = value;
      _dbRef.child('D2').set(value ? 'on' : 'off');
      showCustomGetSnackBar(
        message:
            value ? "Device2 is ON" : "Device2 is OFF", // Display fan state
        icon: value ? Icons.power : Icons.power_off, // Icon for on/off
        backgroundColor:
            value ? Colors.green : Colors.red, // Green for on, red for off
      );
    } else {
      _showReconnectingDialog();
    }
  }

  // Handle fan switch
  void toggleFan(bool value) {
    if (connected.value) {
      isFanOn.value = value;
      fanSpeedValue.value = value ? 1.0 : 0.0;
      _dbRef.child('D3').set(value ? 'on' : 'off');

      // Use the reusable showCustomGetSnackBar function
      showCustomGetSnackBar(
        message:
            value ? "Device3 is ON" : "Device3 is OFF", // Display fan state
        icon: value ? Icons.power : Icons.power_off, // Icon for on/off
        backgroundColor:
            value ? Colors.green : Colors.red, // Green for on, red for off
      );
    } else {
      _showReconnectingDialog();
    }
  }

  // Handle security lamp
  void togglesecurity(bool value) {
    if (connected.value) {
      issecurityon.value = value;
      _dbRef.child('D4').set(value ? 'on' : 'off');
      showCustomGetSnackBar(
        message:
            value ? "Device4 is ON" : "Device4 is OFF", // Display fan state
        icon: value ? Icons.power : Icons.power_off, // Icon for on/off
        backgroundColor:
            value ? Colors.green : Colors.red, // Green for on, red for off
      );
    } else {
      _showReconnectingDialog();
    }
  }

  // Slider control to change fan speed
  var fanSpeedValue = 0.0.obs;

  void updateSliderValue(double value) {
    if (connected.value) {
      fanSpeedValue.value = value;
      if (value == 0.0) {
        isFanOn.value = false;
        _dbRef.child('D3').set('off');
      }
    } else {
      _showReconnectingDialog();
    }
  }

  // Method to get label for the slider value
  String getFanSpeedLabel() {
    return isFanOn.value ? 'Speed ${fanSpeedValue.value.round()}' : 'Off';
  }

  void displayToast(String? title, String message) {
    Get.snackbar(title!, message, duration: const Duration(seconds: 1));
  }
}
