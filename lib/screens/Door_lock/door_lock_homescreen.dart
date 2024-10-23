import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:liquid_dispenser/screens/Door_lock/choose_user_screen.dart';
import 'package:liquid_dispenser/screens/iotScreen/iot_widgets.dart';
import 'package:liquid_dispenser/variables.dart';

class DoorLockHome extends StatelessWidget {
  const DoorLockHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: Text(
            "Smart Door Lock system",
            style: TextStyle(
                color: greencolor,
                fontSize: 25,
                fontWeight: FontWeight.w600,
                fontFamily: "segoeuithis",
                height: 0.7),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              width: width(context, 1),
              height: height(context, 1),
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         colors: [HexColor("#C0DFE8"), HexColor("#FAFDFD")],
              //         begin: Alignment.topCenter)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LET'S KEEP",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontFamily: "segoeuithis"),
                      ),
                      Text(
                        "  YOUR HOME SECURED",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "segoeuithis"),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/wdoor.png",
                          width: 300,
                          height: 400,
                        ),
                        Image.asset(
                          "assets/images/smart_door.png",
                          width: 70,
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "You can now monitor and control your doors from anywhere in the world....",
                    style: TextStyle(
                        fontSize: 18,
                        color: greencolor,
                        fontFamily: "segoeuithis"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => ChooseUser()),
                    child: IotWidgets().customButton(
                        context,
                        width(context, 1),
                        0.0,
                        const Text(
                          "Get Started",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
