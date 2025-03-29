import 'package:flutter/material.dart';
import 'package:prakriti_plant_disease_detection/appui/disease.dart';
import 'package:prakriti_plant_disease_detection/appui/home_page.dart';
import 'package:prakriti_plant_disease_detection/appui/profile.dart';
import 'package:prakriti_plant_disease_detection/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prakriti_plant_disease_detection/utils/assets.dart';

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double avatarRadius = screenHeight * 0.12; // Responsive avatar size
    double spaceTop = screenHeight * 0.2; // Dynamic top spacing
    double bottomImageHeight = screenHeight * 0.3;
    return Scaffold(
        backgroundColor: Color(0xFFF2F9FA),
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              SizedBox(height: spaceTop),
              CircleAvatar(
                  backgroundColor: Color(0xFFF2F9FA),
                  radius: avatarRadius,
                  child: SvgPicture.asset(Assets.login,
                      width: avatarRadius * 2, height: avatarRadius * 2)),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blueAccent)),
                child: const Text(
                  'Get Started',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        Assets.backgr,
                        height: bottomImageHeight,
                      ),
                      Image.asset(Assets.ground, height: 30)
                    ],
                  ))
            ])));
  }
}
