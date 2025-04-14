import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prakriti_plant_disease_detection/appui/home_page.dart';
import 'appui/splash_screen.dart';
import 'firebase_options.dart';
import 'models/tflite_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
// Ensure services are initialized
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    loadModel(); // Load model when the app starts
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prakriti_Plant_Disease_Detection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
      ),
      home: splashScreenPage(),
    );
  }
}
