import 'package:expense_tracker/pages/frontpage/firstpage.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Show splash screen for 3 seconds and then navigate to Homepage
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Firstpage()), // Navigate to Homepage after the splash
      );
    });

    return Scaffold(
      backgroundColor: Colors.blue, // Splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.jpg",
              width: 300,
              height: 300,
            ),
            SizedBox(height: 90),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
