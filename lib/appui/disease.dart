import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/styles.dart';

class DiseasePage extends StatelessWidget {
  final String diseaseName;
  final String accuracy;
  final String description;
  final String treatment;
  final String localRemedies;
  final String imagePath;

  DiseasePage(
      {required this.diseaseName,
      required this.accuracy,
      required this.description,
      required this.treatment,
      required this.localRemedies,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Disease Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight:FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(File(imagePath)), // Add disease image if needed
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  diseaseName,
                  style: const TextStyle(
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.save_alt_outlined)),
              ],
            ),
            Text(
              "with $accuracy Accuracy",
              style: fontstyles.dr1,


            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
                color: Colors.black54,
                fontWeight:FontWeight.w500,

              ),
            ),
            const SizedBox(height: 20),

            // Treatment Section
            const Text(
              "Treatment",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              treatment,
              style: const TextStyle(
                  fontSize: 14, color: Color(0xFF6E6E6E), fontFamily: 'Inter'),
            ),
            const SizedBox(height: 20),

            // Local Remedies
            const Text(
              "Local Remedies",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              localRemedies,
              style: const TextStyle(
                  fontSize: 14, color: Color(0xFF6E6E6E), fontFamily: 'Inter'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:prakriti_plant_disease_detection/appui/home_page.dart';
// import 'package:prakriti_plant_disease_detection/utils/assets.dart';
// import 'package:prakriti_plant_disease_detection/utils/styles.dart';
//
// class diseasePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Text(
//             'Product',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 25,
//               fontFamily: 'Inter',
//               height: 0,
//             ),
//           ),
//           centerTitle: false,
//           actions: [
//             Builder(
//               builder: (context) => IconButton(
//                 icon: Icon(Icons.menu), // Menu icon
//                 onPressed: () {
//                   Scaffold.of(context)
//                       .openEndDrawer(); // Open right-side drawer
//                 },
//               ),
//             ),
//           ],
//         ),
//         endDrawer: SideNavigationDrawer(),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Brown Rust Detection Section
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.asset(Assets.disease), // Disease Image
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       children: [
//                         const Text(
//                           "Brown Rust",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 36,
//                             fontFamily: 'Inter',
//                             height: 0,
//                           ),
//                         ),
//                         SizedBox(width: 40),
//                         IconButton(onPressed: () {}, icon: Icon(Icons.share)),
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.save_alt_outlined)),
//                       ],
//                     ),
//                     const Text(
//                       "with 87% Accuracy",
//                       style: fontstyles.dr1,
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       "Brown rust: A foliar pathogen that spreads through airborne uredospores, especially in the spring.",
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontFamily: 'Inter',
//                           color: Colors.black87),
//                     ),
//                     const SizedBox(height: 10),
//
//                     // Danger Level Section
//                     const Text(
//                       "Danger Level",
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 5),
//                     Container(
//                       width: double.infinity,
//                       height: 10,
//                       decoration: BoxDecoration(
//                         color: Colors.red[100],
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: FractionallySizedBox(
//                         widthFactor: 1.0,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.red[100],
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: const Text(
//                         "High Risk, Immediate Action Required",
//                         style: TextStyle(
//                             color: Colors.red, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Treatment Section
//                     const Text(
//                       "Treatment",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 5),
//                     const Text(
//                       "Control wheat rust with timely fungicide application based on scouting. Treat before infection reaches upper leaves, considering field infection, variety susceptibility, and market price.",
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontFamily: 'Inter',
//                           color: Color(0xFF6E6E6E)),
//                     ),
//                     const SizedBox(height: 10),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Container(), // Treatment Image
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Local Remedies
//                     const Text(
//                       "Local Remedies",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 5),
//                     const Text(
//                       "A mixture of lemon juice and baking soda to create a paste, which can be applied directly to affected areas, or a simple spray solution of diluted vinegar.",
//                       style: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xFF6E6E6E),
//                           fontFamily: 'Inter'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: Colors.white,
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.camera_alt),
//               label: 'Take Picture',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'Profile',
//             ),
//           ],
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.black,
//         ));
//   }
// }
