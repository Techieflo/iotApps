import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:liquid_dispenser/controllers/iot_controller.dart';
import 'package:liquid_dispenser/screens/iotScreen/iot_mainscreen.dart';
import 'package:liquid_dispenser/variables.dart';

class IotHome extends StatelessWidget {
  IotHome({super.key});
  final IotController controller = Get.put(IotController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          body: controller.connected.isFalse
              ? const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          //value: progress.value / 100,
                          backgroundColor: Colors.grey,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "Connecting to IOT Device......",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ],
                  ),
                )
              : iotUI(context)),
    );
  }
}

Widget iotUI(context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 65,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LET'S SET",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "segoeuithis"),
            ),
            Text(
              "  YOU UP",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  fontFamily: "segoeuithis"),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Select Home automation as  \n installation type and click continue ",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "segoeuithis", fontSize: 16, letterSpacing: 1.0),
        ),
        const SizedBox(
          height: 80,
        ),
        InkWell(
          child: OptionCard(),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          child: Card(
            elevation: 0.6,
            child: SizedBox(
              width: width(context, 1.0),
              height: 120,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/route.png"),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Internet Automation",
                          style: TextStyle(
                              fontSize: 19,
                              fontFamily: "segoeuithis",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Internet Cypher 20-34",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "segoeuithis",
                              color: HexColor("0D3C52")),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: height(context, .12),
        ),
        Container(
          height: 70,
          width: width(context, .9),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: HexColor("0C3B52")),
          child: GestureDetector(
            onTap: () => Get.to(() => MainScreen()),
            child: const Center(
              child: Text(
                "Proceed > > >",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "segoeuithis",
                    fontSize: 22,
                    letterSpacing: 2.0),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.6,
      child: SizedBox(
        width: width(context, 1.0),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("assets/images/home.png"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Home Automation",
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: "segoeuithis",
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "ClimaGlow Unit 19-47",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "segoeuithis",
                        color: HexColor("0D3C52")),
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
