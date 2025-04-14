import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prakriti_plant_disease_detection/appui/edit_profile.dart';
import 'package:prakriti_plant_disease_detection/utils/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "John Doe";
  String phone = "+91 9876543210";
  String? imagePath;
  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "John Doe";
      phone = prefs.getString('phone') ?? "701xxxxxx";
      imagePath = prefs.getString('profileImage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My Profile",
          style: TextStyle(
              fontSize: 22,
              fontFamily: 'INTER',
              fontWeight: FontWeight.bold,
              color: Colors.blue),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.blue, size: 30),
        ),
      ),
      body: Column(
        children: [
          // Top Section with Back Button & Clouds
          const SizedBox(height: 40),

          // Profile Picture & Name Section
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Stack(children: [
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()),
                      );
                      _loadProfileData(); // Refresh after editing
                    },
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: imagePath != null
                          ? FileImage(File(imagePath!))
                          : const AssetImage(Assets.cloud)
                      as ImageProvider, // Profile Image
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.blue, size: 20),
                    ),
                  ),
                ]),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  phone,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      color: Colors.black54),
                ),
                TextButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()));
                    _loadProfileData();
                  },
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Profile Menu Options
          Expanded(
            child: Container(
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: ListView(
                children: const [
                  ProfileOption(icon: Icons.download, text: "Downloads"),
                  ProfileOption(icon: Icons.language, text: "Language"),
                  ProfileOption(icon: Icons.location_on, text: "Location"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Profile Option Widget
class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileOption({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue, size: 30),
      title: Text(
        text,
        style: const TextStyle(
            fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500),
      ),
      trailing:
      const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black54),
      onTap: () {},
    );
  }
}