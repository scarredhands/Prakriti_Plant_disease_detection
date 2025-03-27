import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prakriti_plant_disease_detection/utils/assets.dart';
import 'package:prakriti_plant_disease_detection/utils/styles.dart';

import '../functions/preprocessing.dart';
import 'disease.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _showImageSourceDialog(BuildContext context) async {
    final picker = ImagePicker();
    XFile? image;
    // bool _isModelLoaded = false;

    await showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20),
            height: 160,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt, color: Colors.blue),
                  title: Text('Take Picture'),
                  onTap: () async {
                    image = await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      Map<String, dynamic> result = await predictDisease(
                        image!.path,
                      );
                      String label = result['label'];
                      String confidence = result['confidence'];

                      // Navigate to DiseasePage after prediction
                      navigateToDiseasePage(
                        label,
                        confidence,
                        context,
                        image!.path,
                      );
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo, color: Colors.green),
                  title: Text('Choose from Gallery'),
                  onTap: () async {
                    image = await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      Map<String, dynamic> result = await predictDisease(
                        image!.path,
                      );
                      String label = result['label'];
                      String confidence = result['confidence'];

                      // Navigate to DiseasePage after prediction
                      navigateToDiseasePage(
                        label,
                        confidence,
                        context,
                        image!.path,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }

  void navigateToDiseasePage(
    String label,
    String confidence,
    BuildContext context,
    String imagePath,
  ) {
    Map<String, dynamic> diseaseInfo = getDiseaseDetails(label);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => DiseasePage(
              diseaseName: label,
              accuracy:
                  "${(double.parse(confidence) * 100).toStringAsFixed(2)}%",
              description:
                  diseaseInfo['description'] ?? 'No description available',
              treatment: diseaseInfo['treatment'] ?? 'No treatment available',
              localRemedies:
                  diseaseInfo['localRemedies'] ?? 'No local remedies available',
              imagePath: imagePath, // ✅ Pass the image path
            ),
      ),
    );
  }

  Map<String, dynamic> getDiseaseDetails(String diseaseName) {
    Map<String, Map<String, String>> diseaseDetails = {
      "Aphid": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Black Rust": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Blast": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Brown Rust": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Common Root Rot": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Fusarium Head Blight": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Healthy": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Leaf Blight": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Mildew": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Mite": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Septoria": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Smut": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Stem fly": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Tan spot": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
      "Yellow Rust": {
        "description": "Leaf blight causes wilting and drying of leaves.",
        "treatment": "Apply appropriate fungicides.",
        "localRemedies": "Neem oil can help prevent further spread.",
      },
    };

    return diseaseDetails[diseaseName] ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F9FA),
        title: Text(
          'Product',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          Builder(
            builder:
                (context) => IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
          ),
        ],
      ),
      endDrawer: SideNavigationDrawer(),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Color(0xFFF2F9FA),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Guwahati, Assam', style: fontstyles.dr1),
                      SizedBox(height: 5),
                      Text(
                        '45°C',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'The temperature is low \n Weather is cloudy!',
                        style: fontstyles.dr1,
                      ),
                      Spacer(),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(Assets.backgr, height: 220),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Steps to get Accurate results',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Click a picture of the diseased plant or choose one from the gallery to predict the disease.',
                    style: TextStyle(
                      color: Color(0xFF6E6E6E),
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => _showImageSourceDialog(context),
              child: Icon(Icons.camera_alt),
            ),
            label: 'Take Picture',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}

class SideNavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            ListTile(
              title: Text("Settings", style: fontstyles.dr1),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text("About", style: fontstyles.dr1),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text("Terms", style: fontstyles.dr1),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text("Feedback", style: fontstyles.dr1),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:prakriti_plant_disease_detection/utils/assets.dart';
// import 'package:prakriti_plant_disease_detection/utils/styles.dart';
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Color(0xFFF2F9FA),
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
//         body: Column(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Container(
//                   margin: EdgeInsets.only(left: 20),
//                   decoration: BoxDecoration(
//                     color: Color(0xFFF2F9FA),
//                     borderRadius:
//                         BorderRadius.vertical(bottom: Radius.circular(30)),
//                   ),
//                   child: Row(children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Guwahati, Assam',
//                           style: fontstyles.dr1,
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           '45°C',
//                           style: TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blue),
//                         ),
//                         Text(
//                           'The temperature is low \n Weather is cloudy!',
//                           style: fontstyles.dr1,
//                         ),
//                         Spacer(),
//                       ],
//                     ),
//                     Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Align(
//                               alignment: Alignment.topRight,
//                               child: Image.asset(Assets.backgr, height: 220))
//                         ])
//                   ])),
//             ),
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Steps to get Accurate results',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 35,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Inter',
//                         height: 0,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Both adults and nymphs suck the plant sap and excrete honeydew onto leaves, stems, and chlorotic.',
//                       style: TextStyle(
//                         color: Color(0xFF6E6E6E),
//                         fontSize: 14,
//                         fontFamily: 'Inter',
//                         height: 0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
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
//
// class SideNavigationDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: MediaQuery.of(context).size.width * 0.5,
//         child: Drawer(
//           backgroundColor: Colors.white,
//           child: ListView(
//             children: [
//               ListTile(
//                 title: Text("Settings", style: fontstyles.dr1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 title: Text("About", style: fontstyles.dr1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 title: Text("Terms", style: fontstyles.dr1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 title: Text("Feedback", style: fontstyles.dr1),
//                 onTap: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//         ));
//   }
// }
