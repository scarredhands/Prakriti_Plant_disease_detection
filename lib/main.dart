import 'package:flutter/material.dart';
import 'package:prakriti_plant_disease_detection/appui/testui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure services are initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TestScreen(),
    );
  }
}
