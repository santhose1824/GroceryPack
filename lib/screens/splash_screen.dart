import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocery_pack/screens/welcome_screen.dart';
import 'package:grocery_pack/screens/home/home_screen.dart';
import 'package:grocery_pack/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() async {
    // Delay for 3 seconds
    const duration = Duration(seconds: 3);
    await Future.delayed(duration);

    // Check the login status
    final isLoggedIn = await checkLoginStatus();

    // Navigate based on the login status
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => isLoggedIn ? HomeScreen() : WelcomeScreen(),
      ),
    );
  }

  Future<bool> checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      return isLoggedIn;
    } catch (error) {
      // Handle exceptions, e.g., SharedPreferences errors
      print('Error checking login status: $error');
      return false; // Assume not logged in on error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: splashScreenIcon(),
      ),
    );
  }
}

Widget splashScreenIcon() {
  String iconPath = "assets/icons/splash_screen_icon.png";
  return Image.asset(
    iconPath,
    width: 400, // Set the width and height as per your requirements
    height: 400,
  );
}
