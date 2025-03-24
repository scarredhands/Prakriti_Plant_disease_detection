import 'package:flutter/material.dart';
import 'package:prakriti_plant_disease_detection/appui/edit_profile.dart';
import 'package:prakriti_plant_disease_detection/appui/login_page.dart';
void main() {
  runApp(const MyApp());}


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

      home: EditProfileScreen(),
    );
  }
}



