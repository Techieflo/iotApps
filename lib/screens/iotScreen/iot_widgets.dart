import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:liquid_dispenser/variables.dart';

// centered text
class IotWidgets {
  Widget centerText() {
    return Text(
      "All Connected Devices",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 22,
        color: textgreen,
      ),
    );
  }

  Widget customButton(
    BuildContext context,
    width,
    radius,
    Widget child,
  ) {
    return Container(
      height: 70,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: HexColor("0C3B52")),
      child: Center(child: child),
    );
  }

  Widget optionButton(BuildContext context, title, subtitle) {
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
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 19,
                        fontFamily: "segoeuithis",
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
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
