import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:liquid_dispenser/screens/Door_lock/admin_portal.dart';
import 'package:liquid_dispenser/variables.dart';

class AdminController extends GetxController {
  var isConnected = false.obs;
  var connected = true.obs;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final String _hardcodedEmail = adminemail;
  final String _hardcodedPassword = password;

  @override
  void onInit() {
    checkconnection();
    _checkInternetConnection();
    super.onInit();
  }

  // Check internet connection using InternetConnectionChecker
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

  // Show reconnecting dialog
  void _showReconnectingDialog() {
    if (!(Get.isDialogOpen ?? false)) {
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
              const SizedBox(width: 10),
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
              CircularProgressIndicator(color: greencolor),
              const SizedBox(width: 9),
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

  // Hide reconnecting dialog
  void _hideReconnectingDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  // Show connected dialog
  void _showConnectedDialog() {
    Get.dialog(
      CupertinoAlertDialog(
        title: const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 60,
        ),
        content: const Text(
          "Connected to $doorlock_name",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(color: Color.fromARGB(255, 68, 133, 70)),
            ),
          ),
        ],
      ),
    );
  }

  // Check connection status with Firebase Realtime Database
  void checkconnection() {
    _dbRef.child(".info/connected").onValue.listen((event) {
      if (event.snapshot.exists) {
        bool connectionStatus = event.snapshot.value as bool;
        isConnected.value = connectionStatus;
        if (connectionStatus) {
          _showConnectedDialog();
        }
      } else {
        print('No data found for .info/connected');
      }
    }, onError: (error) {
      print('Error checking connection status: $error');
    });
  }

  // Login function
  bool login() {
    _checkInternetConnection();
    if (!connected.value || !isConnected.value) {
      Get.snackbar(
        "Error",
        "No internet connection",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (emailcontroller.text == _hardcodedEmail &&
        passwordcontroller.text == _hardcodedPassword) {
      Get.to(AdminPortal());
      return true;
    } else {
      Get.snackbar(
        "Login Failed",
        "Invalid email or password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }
}
