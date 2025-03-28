import 'package:flutter/material.dart';
import 'package:prakriti_plant_disease_detection/appui/edit_profile.dart';
import 'package:prakriti_plant_disease_detection/utils/assets.dart';
class ProfileScreen extends StatefulWidget {
@override
_ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = "John Doe";
  String _phone = "+91 9876543210";

  void _updateProfile(String name, String phone) {
    setState(() {
      _name = name;
      _phone = phone;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Section with Back Button & Clouds
          Stack(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.cloud), // Cloud background
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.blue, size: 30),
                ),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: const Text(
                  "My Profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontFamily:'INTER',fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ],
          ),

          // Profile Picture & Name Section
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(Assets.cloud), // Profile Image
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
                        child: const Icon(Icons.camera_alt, color: Colors.blue, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                const Text(
                 "Name",
                  style: TextStyle(fontSize: 20,fontFamily: 'Inter', fontWeight: FontWeight.bold),
                ),
                const Text(
                  "hi",
                  style: TextStyle(fontSize: 14,fontFamily: 'Inter', color: Colors.black54),

                ),
                const SizedBox(height: 5),

                ElevatedButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));}
                  , child:  const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 14, fontFamily: 'Inter',color: Colors.blue, fontWeight: FontWeight.bold),
                ),)

              ],
            ),
          ),
          const SizedBox(height: 20),

          // Profile Menu Options
          Expanded(
            child: ListView(
              children: const [
                ProfileOption(icon: Icons.download, text: "Downloads"),
                ProfileOption(icon: Icons.language, text: "Language"),
                ProfileOption(icon: Icons.location_on, text: "Location"),
              ],
            ),
          ),
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
        style: const TextStyle(fontSize: 16, fontFamily: 'Inter',fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black54),
      onTap: () {},
    );
  }
}
