import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:liquid_dispenser/controllers/iot_controller.dart';
import 'package:liquid_dispenser/screens/iotScreen/iot_widgets.dart';
import 'package:liquid_dispenser/variables.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final IotController controller = Get.put(IotController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu_outlined),
        title: Row(
          children: [
            Text(
              " 1902 Home Automation system",
              style: TextStyle(
                  fontFamily: "segoeuithis",
                  color: textgreen,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.arrow_drop_down_sharp)
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            // SizedBox(
            //   height: height(context, 0.03),
            // ),
            Center(child: IotWidgets().centerText()),
            const SizedBox(
              height: 15,
            ),
            Card(
              elevation: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      HexColor("F6FAFF"),
                      const Color(0xFFF7FBFF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                width: width(context, 1.0),
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/idea.png", height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                radius: 5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                radius: 5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                radius: 5,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 08,
                          ),
                          const Text(
                            "DEVICE 1",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "segoeuithis",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Iot Device 1",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "segoeuithis",
                                color: HexColor("0D3C52")),
                          ),
                        ],
                      ),
                      Obx(
                        () => Switch(
                          value: controller.ceilinglampon.value,
                          onChanged: controller.toggleSwitch,
                          activeColor: textgreen,
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Colors.red[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Card(
              elevation: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      HexColor("F6FAFF"),
                      const Color(0xFFF7FBFF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                width: width(context, 1.0),
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/walllamp.png", height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                radius: 5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                radius: 5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                radius: 5,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 08,
                          ),
                          const Text(
                            "DEVICE 2 ",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "segoeuithis",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Iot Device 2",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "segoeuithis",
                                color: HexColor("0D3C52")),
                          ),
                        ],
                      ),
                      Obx(
                        () => Switch(
                          value: controller.iswallon.value,
                          onChanged: controller.togglewall,
                          activeColor: textgreen,
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Colors.red[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Card(
              elevation: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      HexColor("F6FAFF"),
                      const Color(0xFFF7FBFF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                width: width(context, 1.0),
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/any.png", height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                radius: 5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                radius: 5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                radius: 5,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 08,
                          ),
                          const Text(
                            " DEVICE 3",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "segoeuithis",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Iot Device 3",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "segoeuithis",
                                color: HexColor("0D3C52")),
                          ),
                          // Row(
                          //   children: [
                          //     Obx(() => Slider(
                          //           activeColor: greencolor,
                          //           value: controller.fanSpeedValue.value,
                          //           onChanged: controller.isFanOn.value
                          //               ? controller.updateSliderValue
                          //               : null,
                          //           min: 0.0,
                          //           max: 2.0,
                          //           divisions: 2,
                          //           label: controller.getFanSpeedLabel(),
                          //           inactiveColor: controller.isFanOn.value
                          //               ? null
                          //               : Colors
                          //                   .grey, // Change the color to indicate inactive state
                          //         )),
                          //   ],
                          // ),
                        ],
                      ),
                      Obx(
                        () => Switch(
                          value: controller.isFanOn.value,
                          onChanged: controller.toggleFan,
                          activeColor: textgreen,
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Colors.red[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //securtiy lamp
            Card(
              elevation: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      HexColor("F6FAFF"),
                      const Color(0xFFF7FBFF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                width: width(context, 1.0),
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/any.png", height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                radius: 5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                radius: 5,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                radius: 5,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 08,
                          ),
                          const Text(
                            "DEVICE 4",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "segoeuithis",
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Iot Device 4",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "segoeuithis",
                                color: HexColor("0D3C52")),
                          ),
                        ],
                      ),
                      Obx(
                        () => Switch(
                          value: controller.issecurityon.value,
                          onChanged: controller.togglesecurity,
                          activeColor: textgreen,
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Colors.red[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                controller.displayToast("Refresh Devices", "Refresh completed");
              },
              child: IotWidgets().customButton(
                context,
                width(context, .19),
                20.0,
                const Icon(
                  Icons.refresh_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
