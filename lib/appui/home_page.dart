import 'package:flutter/material.dart';
import 'package:prakriti_plant_disease_detection/utils/assets.dart';
import 'package:prakriti_plant_disease_detection/utils/styles.dart';

class HomePage extends StatelessWidget {
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
              height: 0,
            ),
          ),
          centerTitle: false,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu), // Menu icon
                onPressed: () {
                  Scaffold.of(context)
                      .openEndDrawer(); // Open right-side drawer
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
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                  child: Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Guwahati, Assam',
                          style: fontstyles.dr1,
                        ),
                        SizedBox(height: 5),
                        Text(
                          '45°C',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        Text(
                          'The temperature is low \n Weather is cloudy!',
                          style: fontstyles.dr1,
                        ),
                        Spacer(),
                      ],
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(Assets.backgr, height: 220))
                        ])
                  ])),
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
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Both adults and nymphs suck the plant sap and excrete honeydew onto leaves, stems, and chlorotic.',
                      style: TextStyle(
                        color: Color(0xFF6E6E6E),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        height: 0,
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
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: 'Take Picture',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
        ));
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
        ));
  }
}
