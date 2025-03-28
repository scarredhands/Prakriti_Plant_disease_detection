import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prakriti_plant_disease_detection/appui/home_page.dart';
import 'package:prakriti_plant_disease_detection/appui/profile.dart';
import 'dart:io';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  File? _image;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HomePage(),// Placeholder for Camera
    ProfileScreen(),
  ];

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _selectedIndex = 1; // Switch to Camera Screen
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      _pickImage(); // Open Camera
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
