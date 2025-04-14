import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prakriti_plant_disease_detection/appui/profile.dart';
import 'package:prakriti_plant_disease_detection/utils/assets.dart';
import 'package:prakriti_plant_disease_detection/utils/styles.dart';

import '../functions/preprocessing.dart';
import '../widgets/bottom_nav_bar.dart';
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
      builder: (context) => Container(
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
        builder: (context) => DiseasePage(
          diseaseName: label,
          accuracy: "${(double.parse(confidence) * 100).toStringAsFixed(2)}%",
          description: diseaseInfo['description'] ?? 'No description available',
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
        "description":
            "1. Clusters of small, soft-bodied insects (green, black, or brown) on leaves and stems\n 2.Curling, yellowing, and wilting of leaves due to sap sucking.\n3.Honeydew secretion leads to sooty mold growth, blocking photosynthesis.\n4.Transmit viral diseases like Barley Yellow Dwarf Virus (BYDV).",
        "treatment":
            "1. Spray insecticides like Imidacloprid or Thiamethoxam at early infestation.\n2. Early sowing to avoid peak aphid activity.\n3. Encourage natural predators (ladybugs, lacewings), destroy weeds that act as aphid hosts.",
        "localRemedies":
            " Neem oil spray (natural insect repellent), Garlic-chili extract spray to deter aphids.",
      },
      "Black Rust": {
        "description":
            "1. Reddish-brown pustules (a small pimple-like eruption from the surface of part of a plant) on leaves and stems, later turning black.\n2. Weakens plants, causes lodging (plants falling over) and yield loss.\n3. Occurs in warm temperatures (18-30°C) and high humidity.",
        "treatment":
            "1. Spray fungicides at early stages. e.g. Propiconazole, Tebuconazole, or Mancozeb\n2. Grow resistant varieties (e.g., HD 2967), remove barberry plants (thorny shrubs), and practice crop rotation.",
        "localRemedies":
            "Spray neem extract, garlic extract, or a cow dung-buttermilk solution for antifungal effects..",
      },
      "Blast": {
        "description":
            "1. Grayish lesions (spots or areas of damage or abnormal tissue development on a plant) on spikes (grain bearing organ), leading to premature bleaching.\n2. Infected grains shrink, become chalky (paleness of colour), and fail to develop properly.\n3. Occurs in warm, humid conditions (18–30°C) with frequent rain.",
        "treatment":
            "1. Spray fungicides at early stages. e.g. Tebuconazole or Azoxystrobin.\n2. Use blast-resistant wheat varieties, practice crop rotation, and avoid late sowing.",
        "localRemedies":
            "Neem oil spray (antifungal properties), Cow dung-buttermilk solution to suppress fungal spores, Wood ash dusting around plants to absorb moisture and limit fungal spread.",
      },
      "Brown Rust": {
        "description":
            "1. Small, circular orange-brown pustules (a small pimple-like eruption from the surface of part of a plant) on leaves, mainly on the upper surface.\n2. Severe infection causes yellowing, drying, and early leaf drop, reducing yield.\n3. Favored by cool temperatures (15–22°C) and moisture.",
        "treatment":
            "1. Spray fungicides at early stages. e.g. Propiconazole, Tebuconazole\n2. Grow rust-resistant varieties (e.g., HD 2967), practice crop rotation, and avoid excessive nitrogen fertilization.",
        "localRemedies":
            "Spray neem extract, garlic extract, or a cow dung-buttermilk solution (boost plant immunity) for antifungal effects..",
      },
      "Common Root Rot": {
        "description":
            "1. Dark brown to black lesions (spots or areas of damage or abnormal tissue development on a plant) on roots and lower stem.\n2. Stunted growth, yellowing, and wilting of plants.\n3. Roots become brittle and decay, leading to plant death in severe cases.\n4. Occurs in warm, dry soils with poor drainage.",
        "treatment":
            "1. Treat seeds with fungicides like Carbendazim or Thiram before sowing.\n2. Rotate crops with non-hosts (e.g., pulses, mustard), improve soil drainage and avoid overcrowding plants, use healthy, disease-free seeds.",
        "localRemedies":
            "3. Neem cake or mustard cake in the soil to suppress fungi, cow dung compost to enhance beneficial microbes in soil.\n4. Trichoderma bio-fungicide (mix with compost or apply to seeds).",
      },
      "Fusarium Head Blight": {
        "description":
            "1. Bleached, whitish spikelet's on wheat heads.\n2. Shriveled, discolored grains with a pinkish or white fungal growth.\n3. Produces mycotoxins (DON toxin), making grains unsafe for consumption.\n4. Favored by warm, humid weather (20–30°C) and prolonged moisture.",
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarRadius = screenHeight * 0.12; // Responsive avatar size
    double spaceTop = screenHeight * 0.2; // Dynamic top spacing
    double bottomImageHeight = screenHeight * 0.3;
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
            builder: (context) => IconButton(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding:EdgeInsets.all(16),
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
                    child: Image.asset(Assets.wheat, height:screenHeight*0.5,width:screenWidth*0.3),
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
          BottomNavigationBarItem(icon:  GestureDetector(
              onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) =>HomePage()));},child:Icon(Icons.home)), label: 'Home'),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => _showImageSourceDialog(context),
              child: Icon(Icons.camera_alt),
            ),
            label: 'Take Picture',
          ),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  child: Icon(Icons.person), onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => ProfileScreen()));}),
              label: 'Profile'),
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
