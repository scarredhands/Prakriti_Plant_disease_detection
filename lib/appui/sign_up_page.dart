import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print("User signed up: ${userCredential.user?.email}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F9FA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Center( child:Text("Sign Up",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),),
              SizedBox(height: 40),
              TextField(
                controller: nameController,
                decoration: _inputDecoration("Name").copyWith(
                  constraints: BoxConstraints(maxHeight:50.0),
                  labelText: "Name",
                  floatingLabelAlignment: FloatingLabelAlignment.start
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration("Phone number",).copyWith(
                  labelText: "Phone",
                  constraints: BoxConstraints(maxHeight:50.0),)
              ),
              SizedBox(height: 20),
              TextField(
                controller: cityController,
                decoration: _inputDecoration("City").copyWith(
                  labelText: "City",

                  constraints: BoxConstraints(maxHeight:50.0),)
              ),
              SizedBox(height: 20),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration("Email").copyWith(
                    labelText: "Email",
                    constraints: BoxConstraints(maxHeight:50.0)),
              ),
              SizedBox(height: 20),

              TextField(
                controller: passwordController,
                decoration: _inputDecoration("Password").copyWith(
                    labelText: "Password",

                    constraints: BoxConstraints(maxHeight:50.0)),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: (){signUp(context);},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: Text(
                    "Continue",
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
              SizedBox(height: 20),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Have an account? ",
                    style: TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to signup page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
