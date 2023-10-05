import 'package:flutter/material.dart';
import 'package:grocery_pack/screens/home/home_screen.dart';
import 'package:grocery_pack/screens/splash_screen.dart';
import 'package:grocery_pack/screens/welcome_screen.dart';
import 'package:grocery_pack/styles/theme.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: AppStartup(),
    );
  }
}

class AppStartup extends StatefulWidget {
  @override
  _AppStartupState createState() => _AppStartupState();
}

class _AppStartupState extends State<AppStartup> {
  @override
  void initState() {
    super.initState();
    // Delay the execution of _checkLoginStatus
    Future.delayed(Duration.zero, () {
      _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Check if the user is already logged in or not
    if (isLoggedIn) {
      // If logged in, navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // If not logged in, navigate to the welcome screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(); // Show the splash screen while checking login status
  }
}
