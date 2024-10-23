import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:liquid_dispenser/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:liquid_dispenser/screens/Door_lock/door_lock_homescreen.dart';
import 'package:liquid_dispenser/variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home Automation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: greencolor),
        useMaterial3: true,
      ),
      home: DoorLockHome(),
    );
  }
}
