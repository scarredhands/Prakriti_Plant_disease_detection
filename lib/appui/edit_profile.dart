import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:prakriti_plant_disease_detection/appui/login_page.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveImage(File image) async {
    final prefs = await SharedPreferences.getInstance();
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/profile_pic.png';
    await image.copy(imagePath);
    prefs.setString('profile_image', imagePath);
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      String? imagePath = prefs.getString('profile_image');
      if (imagePath != null) {
        _image = File(imagePath);
      }
    });
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nameController.text);
    prefs.setString('phone', phoneController.text);
    if (_image != null) {
      await prefs.setString('profileImage', _image!.path);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Profile Saved!')));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double avatarRadius = screenHeight * 0.12; // Responsive avatar size
    double bottomImageHeight = screenHeight * 0.3;
    return Scaffold(
      appBar: AppBar(
          title: Text("Edit Profile",
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w500))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: bottomImageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: _image != null
                                ? FileImage(_image!)
                                : AssetImage("assets/images/wheat")
                                    as ImageProvider,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    focusColor: Colors.blue,
                    labelText: "Name",
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Colors.blue,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  )),
              SizedBox(height: 20),
              TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    iconColor: Colors.blue,
                    hoverColor: Colors.blue,
                    labelText: "Phone Number",
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                    prefixIcon: Icon(Icons.phone),
                    prefixIconColor: Colors.blue,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  )),
              SizedBox(height: 25),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: _saveProfile,
                  child: Text("Save Profile",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500))),
            ],
          ),
        ),
      ),
    );
  }
}
