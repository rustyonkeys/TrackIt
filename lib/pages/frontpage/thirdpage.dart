import 'package:expense_tracker/pages/frontpage/loginpage.dart';
import 'package:expense_tracker/pages/frontpage/signinpage.dart';
import 'package:flutter/material.dart';

class Thirdpage extends StatelessWidget {
  const Thirdpage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.08,
          vertical: height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "TrackIT.",
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: height * 0.05),
            Image.asset(
              "assets/thirdpage.jpg",
              width: width * 0.9,
              height: height * 0.4,
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "The Fastest Way ",
                  style: TextStyle(
                    fontSize: width * 0.1,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                Text(
                  "To Track Your",
                  style: TextStyle(
                    fontSize: width * 0.1,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                Text(
                  "Expenses",
                  style: TextStyle(
                    fontSize: width * 0.1,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Take your spending instantly and make your ",
                  style: TextStyle(
                    fontSize: width * 0.0352,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "finances organized with zero hassle.",
                  style: TextStyle(
                    fontSize: width * 0.0352,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signinpage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(width * 0.41, height * 0.06),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Loginpage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(width * 0.41, height * 0.06),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.white,
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
