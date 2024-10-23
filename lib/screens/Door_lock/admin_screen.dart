import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_dispenser/controllers/admin_access_controller.dart';
import 'package:liquid_dispenser/screens/Door_lock/admin_portal.dart';

import 'package:liquid_dispenser/screens/iotScreen/iot_widgets.dart';
import 'package:liquid_dispenser/screens/subwidgets/wcontainer.dart';
import 'package:liquid_dispenser/variables.dart';

class AdminPage extends StatelessWidget {
  AdminPage({super.key});
  final AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ADMIN LOGIN",
          style: TextStyle(color: textgreen, fontWeight: FontWeight.w400),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 90,
            ),
            eInputwidget(
                margin: 10.0,
                controller: adminController.emailcontroller,
                hinttext: "Enter Email Address",
                radius: 0.0,
                textinputype: TextInputType.emailAddress,
                ispassword: false),
            const SizedBox(
              height: 30,
            ),
            eInputwidget(
                margin: 10.0,
                controller: adminController.passwordcontroller,
                hinttext: "Enter Password",
                radius: 0.0,
                textinputype: TextInputType.name,
                ispassword: true),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                adminController.login();
                // Get.to(AdminPortal());
              },
              child: IotWidgets().customButton(
                  context,
                  width(context, 1),
                  0.0,
                  const Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
