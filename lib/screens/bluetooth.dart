import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_dispenser/controllers/pumpcontroller.dart';

class PumpStateScreen extends StatelessWidget {
  final PumpStateController controller = Get.put(PumpStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pump State'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() => Text(
                  controller.obstacleDetected.value
                      ? 'Obstacle Detected'
                      : 'No Obstacle',
                  style: TextStyle(fontSize: 24),
                )),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: () {},
                  child: Text(controller.pumpState.value == 'off'
                      ? 'Turn Pump On'
                      : 'Turn Pump Off'),
                )),
          ],
        ),
      ),
    );
  }
}
