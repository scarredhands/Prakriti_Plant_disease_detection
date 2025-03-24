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
    return Scaffold(
        backgroundColor: Color(0xFFF2F9FA),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Positioned(
                    top: 50,
                    child: Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(Assets.login, height: 200))),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.blueAccent)),
                  child: const Text(
                    'Get Started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                    ),
                  ),
                )
              ]),
          Positioned(
              bottom:0,
              right:0,
              child: Container(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment:CrossAxisAlignment.end,
                children: [
                  Image.asset(Assets.backgr, height: 250),
                  Image.asset(Assets.ground, height: 30)
                ],
              )))
        ]));
  }
}
