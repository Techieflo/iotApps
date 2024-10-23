import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_dispenser/controllers/doorLock_controller.dart';
//import 'package:liquid_dispenser/controllers/doorLock_controller.dart';
import 'package:liquid_dispenser/controllers/navigation%20controllers.dart';
import 'package:liquid_dispenser/screens/Door_lock/admin_screen.dart';
import 'package:liquid_dispenser/screens/Door_lock/user_screen.dart';
import 'package:liquid_dispenser/screens/iotScreen/iot_widgets.dart';

class ChooseUser extends StatelessWidget {
  ChooseUser({super.key});

  final NavigationController navigationController =
      Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Select AdminLogin as Home owner and UserLogin to gain access",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "segoeuithis",
                  fontSize: 16,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () => Get.to(() => AdminPage()),
              child: IotWidgets().optionButton(
                  context, "Admin Login", "Continue as Home owner"),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                navigationController.navigateToNextPage(UserScreen());
              },
              child: IotWidgets()
                  .optionButton(context, "User Login", "Continue as User"),
            ),
          ],
        ),
      ),
    );
  }
}
