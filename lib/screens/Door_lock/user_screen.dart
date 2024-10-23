import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_dispenser/controllers/doorLock_controller.dart';
import 'package:liquid_dispenser/variables.dart';
import 'package:qr_bar_code/qr/src/qr_code.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});
  final DoorLockController controller = Get.put(DoorLockController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: Text(
          "USER LOGIN",
          style: TextStyle(color: textgreen, fontWeight: FontWeight.w400),
        ),
      ),
      body: Center(
          child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Scan the QR Code below to request access",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "segoeuithis",
                    fontSize: 19,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w400,
                    color: greencolor),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                height: 300,
                width: 300,
                child: QRCode(
                  data: qrPassword1,
                ),
              ),
             const  SizedBox(height: 50),
              Obx(() => Text(
                    "  ${controller.timervalue.value} : 00 seconds remaining ",
                    style: TextStyle(color: textgreen, fontSize: 18),
                  ))
            ],
          ),
        ],
      )),
    );
  }
}
