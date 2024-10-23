import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_dispenser/variables.dart';

class DoorLockController extends GetxController {
  var timervalue = 35.obs;
  Timer? _timer;
  var scansuccessful = false.obs;
  var scantimeout = false.obs;

  @override
  void onClose() {
    cancelTimer();
    Get.delete<DoorLockController>(force: true);
    super.onClose();
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => super.onDelete;
  @override
  @override
  void onReady() {
    startTimer();
    super.onReady();
  }

  // function to cancel timer
  void cancelTimer() {
    _timer?.cancel();
  }

  //Timer
  void startTimer() {
    timervalue.value = 35;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (scansuccessful.value) {
        _timer?.cancel();
        successDialog();
      } else if (timervalue.value > 0) {
        timervalue.value--;
      } else {
        _timer?.cancel();
        actionAfterTimeout();
      }
    });
  }

//
  void showScanSuccessfulDialog() {
    // Implement the logic to show the dialog for scan successful
    Get.dialog(
      AlertDialog(
        title: const Text('Scan Successful'),
        content: const Text('The scan was successful.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void actionAfterTimeout() {
    scantimeout.value = true;
    errorDialog(
        title: "Scanning TimeOut!",
        subtitle: "Refresh QR CODE and \n Request Access ");
  }

//function to always display dialogue
  errorDialog({required String title, required String subtitle}) {
    if (!Get.isDialogOpen!) {
      Get.dialog(
        CupertinoAlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                maxLines: 2,
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
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: textgreen,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                startTimer();
              },
              child: const Text("OK"),
            )
          ],
        ),
        barrierDismissible: true,
      );
    }
  }

  successDialog() {
    Get.dialog(
      CupertinoAlertDialog(
        title: const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 60,
        ),
        content: Column(
          children: [
            const Text(
              "Scan Successful",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(children: [
              CircularProgressIndicator(
                color: greencolor,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Waiting for Admin Access...")
            ])
          ],
        ),
        // actions: <Widget>[
        //   TextButton(
        //     onPressed: () {
        //       //  Get.back();
        //     },
        //     child: const Text(
        //       "Ok",
        //       style: TextStyle(color: Color.fromARGB(255, 68, 133, 70)),
        //     ),
        //   ),
        // ],
      ),
      barrierDismissible: false,
    );
  }
}
