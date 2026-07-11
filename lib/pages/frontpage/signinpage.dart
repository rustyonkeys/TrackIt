import 'package:expense_tracker/pages/frontpage/loginpage.dart';
import 'package:expense_tracker/util/bottomnavbar.dart';
import 'package:flutter/material.dart';

class Signinpage extends StatelessWidget {
  const Signinpage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(height: 60,),
            Text(
              "Get started with TrackIT",
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.0013),
            Text(
              "Create a secure account in just a few steps",
              style: TextStyle(
                fontSize: width * 0.04,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.026,
                horizontal: width * 0.026,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email", style: TextStyle(fontSize: width * 0.038)),
                  SizedBox(height: height * 0.005),
                  TextField(
                    decoration: InputDecoration(
                      // labelText: 'Email',
                      hintText: "Enter email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.027),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.035),
                  Text("Password", style: TextStyle(fontSize: width * 0.038)),
                  SizedBox(height: height * 0.005),
                  TextField(
                    decoration: InputDecoration(
                      // labelText: 'Password',
                      hintText: "Enter Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.027),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.015),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Bottomnavbar()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width * 0.9, height * 0.06),
                backgroundColor: Colors.black,
              ),
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: width * 0.04),
              ),
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: width * 0.039,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Loginpage()),
                    );
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: width * 0.039,
                      // fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
