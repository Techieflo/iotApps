import 'package:flutter/material.dart';

Widget wcontainer(icon, text, margin, bool? space) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromRGBO(167, 234, 249, 1)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Row(
        mainAxisAlignment:
            space! ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 18,
          ),
          SizedBox(height: 20, width: 20, child: icon),
          const SizedBox(
            width: 18,
          ),
          Text(
            text,
            style: const TextStyle(
                fontSize: 20,
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}

Widget inputwidget(margin, TextEditingController controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: margin),
    margin: EdgeInsets.symmetric(horizontal: margin),
    height: 50,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black54),
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
    ),
    child: SizedBox(
      child: TextField(
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Input Water Volume in ml",
            hintStyle: TextStyle(color: Colors.grey)),
        autofocus: false,
        keyboardType: TextInputType.number,
        controller: controller,
      ),
    ),
  );
}

// editable  inputWdidget
Widget eInputwidget({
  required margin,
  required TextEditingController controller,
  required String hinttext,
  required double radius,
  required bool ispassword,
  required TextInputType textinputype,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: margin),
    margin: EdgeInsets.symmetric(horizontal: margin),
    height: 50,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black54),
      borderRadius: BorderRadius.circular(radius),
      color: Colors.white,
    ),
    child: SizedBox(
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hinttext,
            hintStyle: const TextStyle(color: Colors.grey)),
        autofocus: false,
        obscureText: ispassword ? true : false,
        keyboardType: textinputype,
        controller: controller,
      ),
    ),
  );
}

Widget dispensewidget(icon, text, margin, bool? space) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 57, 152, 173)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Row(
        mainAxisAlignment:
            space! ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 18,
          ),
          SizedBox(height: 20, width: 20, child: icon),
          const SizedBox(
            width: 18,
          ),
          Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}

Widget nactivatedispensewidget(icon, text, margin, bool? space) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 199, 242, 252)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Row(
        mainAxisAlignment:
            space! ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 18,
          ),
          SizedBox(height: 20, width: 20, child: icon),
          const SizedBox(
            width: 18,
          ),
          Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
