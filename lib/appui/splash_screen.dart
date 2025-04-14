import 'package:flutter/material.dart';
import 'package:prakriti_plant_disease_detection/appui/disease.dart';
import 'package:prakriti_plant_disease_detection/appui/home_page.dart';
import 'package:prakriti_plant_disease_detection/appui/profile.dart';
import 'package:prakriti_plant_disease_detection/appui/sign_up_page.dart';
import 'package:prakriti_plant_disease_detection/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prakriti_plant_disease_detection/utils/assets.dart';

import 'login_page.dart';

class splashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double avatarRadius = screenHeight * 0.12; // Responsive avatar size
    double spaceTop = screenHeight * 0.2; // Dynamic top spacing
    double bottomImageHeight = screenHeight * 0.3;
    return Scaffold(
        backgroundColor: Color(0xFFF2F9FA),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: spaceTop),
              CircleAvatar(
                  backgroundColor: Color(0xFFF2F9FA),
                  radius: avatarRadius,
                  child: SvgPicture.asset(Assets.login,
                      width: avatarRadius * 2, height: avatarRadius * 2)),
              SizedBox(height: 49),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Colors.blue),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            child: const Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            child: const Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
            ]));
    // Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Expanded(child: Container()),
    //   Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Positioned(
    //             top: 50,
    //             child: Container(
    //                 alignment: Alignment.center,
    //                 child: SvgPicture.asset(Assets.login, height: 200))),
    //         SizedBox(height: 50),
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    //           },
    //           style: ButtonStyle(
    //               backgroundColor:
    //                   WidgetStatePropertyAll(Colors.blueAccent)),
    //           child: const Text(
    //             'Get Started',
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 20,
    //               fontFamily: 'Inter',
    //             ),
    //           ),
    //         )
    //       ]),
    //   Positioned(
    //       bottom:0,
    //       right:0,
    //       child: Container(
    //       alignment: Alignment.bottomRight,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         crossAxisAlignment:CrossAxisAlignment.end,
    //         children: [
    //           Image.asset(Assets.backgr, height: 250),
    //           Image.asset(Assets.ground, height: 30)
    //         ],
    //       )))
    // ]));
  }
}
