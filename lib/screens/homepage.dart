import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_dispenser/controllers/pumpcontroller.dart';
import 'package:liquid_dispenser/screens/subwidgets/wcontainer.dart';
import 'package:liquid_dispenser/variables.dart';

class Homepage extends StatelessWidget {
  final PumpStateController controller = Get.put(PumpStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              height: height(context, .39),
              image: const AssetImage("assets/images/dispenser.jpg"),
            ),
            Obx(() => wcontainer(
                  controller.isConnected.value
                      ? const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 20.0,
                        )
                      : const CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: Colors.black,
                        ),
                  "Dispenser Model 43-65",
                  30.0,
                  false,
                )),
            const SizedBox(height: 20),
            inputwidget(30.0, controller.inputController),
            const SizedBox(height: 20),
            Obx(() => controller.obstacleDetected.value
                ? GestureDetector(
                    onTap: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (ctx) => CupertinoAlertDialog(
                      //     title: const Icon(
                      //       Icons.check_circle_outline,
                      //       color: Colors.green,
                      //       size: 60,
                      //     ),
                      //     content: const Text(
                      //       "Dispense Completed",
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //     actions: <Widget>[
                      //       TextButton(
                      //         onPressed: () {
                      //           Navigator.of(ctx).pop();
                      //         },
                      //         child: const Text(
                      //           "Ok",
                      //           style: TextStyle(
                      //               color: Color.fromARGB(255, 68, 133, 70)),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // );
                      controller.handleInput();
                    },
                    child: dispensewidget(
                      const CircularProgressIndicator(
                        color: Colors.black,
                        backgroundColor: Colors.grey,
                      ),
                      "Dispense",
                      60.0,
                      true,
                    ),
                  )
                : nactivatedispensewidget(
                    const CircularProgressIndicator(
                      color: Colors.black12,
                      backgroundColor: Colors.transparent,
                    ),
                    "Dispense",
                    60.0,
                    true)),
            Obx(() => controller.obstacleDetected.value
                ? Image(
                    height: height(context, .3),
                    image: const AssetImage("assets/images/cup.png"),
                  )
                : Container(
                    child: Column(
                      children: [
                        SizedBox(height: height(context, .19)),
                        const Text("Place the cup in allocated place"),
                        SizedBox(height: height(context, .08)),
                      ],
                    ),
                  )),
            Obx(() => wcontainer(
                  SizedBox(
                    child: controller.obstacleDetected.value
                        ? const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 30.0,
                          )
                        : const Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                            size: 30.0,
                          ),
                  ),
                  controller.obstacleDetected.value
                      ? "Cup detected"
                      : "Cup Not detected",
                  80.0,
                  true,
                )),
          ],
        ),
      ),
    );
  }
}
