import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_dispenser/variables.dart';

class PumpStateController extends GetxController {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  var obstacleDetected = false.obs;
  var isButtonEnabled = false.obs;
  var pumpState = 'off'.obs;
  var isConnected = false.obs;
  var progress = 0.0.obs; // Observable to track progress percentage

  // TextEditingController for the input field
  final TextEditingController inputController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    print('PumpStateController initialized');

    // Check initial connection status
    FirebaseDatabase.instance.ref().child(".info/connected").onValue.listen(
        (event) {
      bool connectionStatus = event.snapshot.value as bool;
      isConnected.value = connectionStatus;
      print('Connection status changed: ${isConnected.value}');
      if (connectionStatus) {
        _showConnectedDialog();
      }
    }, onError: (error) {
      print('Error checking connection status: $error');
    });

    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      print('Database value changed: $data');

      if (data != null) {
        // Handle pumpState
        if (data.containsKey('pumpState')) {
          final pumpStateMap = data['pumpState'];
          if (pumpStateMap is Map) {
            final pumpStateValue = pumpStateMap['pumpState'];
            if (pumpStateValue is String) {
              pumpState.value = pumpStateValue;
              print('Pump state updated: ${pumpState.value}');
            } else {
              pumpState.value = 'off'; // Default to 'off' if not a String
              print('Invalid pump state value, set to default: off');
            }
          }
        } else {
          pumpState.value = 'off'; // Default to 'off' if key not found
          print('pumpState key not found, set to default: off');
        }

        // Handle buttonClick
        if (data.containsKey('buttonClick')) {
          final buttonClick = data['buttonClick'];
          if (buttonClick is bool) {
            obstacleDetected.value = buttonClick;
            isButtonEnabled.value =
                buttonClick; // Enable button if obstacle detected
            print('Button click updated: ${buttonClick}');
          } else {
            obstacleDetected.value = false; // Default to false if not a bool
            isButtonEnabled.value = false; // Default to false if not a bool
            print('Invalid button click value, set to default: false');
          }
        } else {
          obstacleDetected.value = false; // Default to false if key not found
          isButtonEnabled.value = false; // Default to false if key not found
          print('buttonClick key not found, set to default: false');
        }
      } else {
        obstacleDetected.value = false;
        isButtonEnabled.value = false;
        print('No data received from database, set default values');
      }
    }, onError: (error) {
      print('Error listening to database changes: $error');
    });

    print("Initial obstacle detected: ${obstacleDetected.value}");
  }

  void setPumpState(String state) {
    _dbRef.child('pumpState').set({'pumpState': state}).then((_) {
      pumpState.value = state;
      print('Pump state set to: ${pumpState.value}');
    }).catchError((error) {
      print('Failed to update pump state: $error');
    });
  }

  void _showConnectedDialog() {
    print("Showing connected dialog");
    Get.dialog(
      CupertinoAlertDialog(
        title: const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 60,
        ),
        content: const Text(
          "Connected to $dispenser_name",
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

  void handleInput() {
    if (inputController.text.isNotEmpty) {
      double inputValue = double.parse(inputController.text);
      double result = inputValue / 100;
      print('Input value: $inputValue, Divided value: $result');
      _showDispensingDialog(result);
      inputController.clear();
    } else {
      _showErrorDialog("Please enter a volume of water not less than 1000ml.");
      print('Input field is empty');
    }
  }

  void _showDispensingDialog(double seconds) {
    print("Showing dispensing dialog for $seconds seconds");
    progress.value = 0.0; // Reset progress

    Get.dialog(
      Obx(() => CupertinoAlertDialog(
            title: Center(
              child: CircularProgressIndicator(
                value: progress.value / 100,
                backgroundColor: Colors.grey,
                color: Colors.green,
              ),
            ),
            content: Column(
              children: [
                const Divider(),
                Text(
                  "Dispensing... ${progress.value.toInt()}%",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
      barrierDismissible: false,
    );

    dispense(seconds);
  }

  void dispense(double seconds) {
    setPumpState('on');
    final int interval = 100; // update every 100 milliseconds
    final int totalUpdates = (seconds * 1000 / interval).toInt();
    int updateCount = 0;

    Timer.periodic(Duration(milliseconds: interval), (timer) {
      updateCount++;
      progress.value = (updateCount / totalUpdates) * 100;
      if (updateCount >= totalUpdates) {
        timer.cancel();
        setPumpState('off');
        print('Dispensing completed after $seconds seconds');
        Get.back();
        _showCompletedDialog();
      }
    });
  }

  void _showCompletedDialog() {
    print("Showing completed dialog");
    Get.dialog(
      CupertinoAlertDialog(
        title: const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 60,
        ),
        content: const Text(
          "Dispense Completed",
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

  void _showErrorDialog(String message) {
    print("Showing error dialog: $message");
    Get.dialog(
      CupertinoAlertDialog(
        title: const Icon(
          Icons.error,
          color: Colors.red,
          size: 60,
        ),
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
