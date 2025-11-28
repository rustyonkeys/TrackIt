import 'package:expense_tracker/pages/frontpage/thirdpage.dart';
import 'package:flutter/material.dart';

class Secondpage extends StatelessWidget {
  const Secondpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 600,),
            Text("Visualize Your ",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  height: 1
              ),),
            Text("Spending.",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                  height: 1
              ),),
            Text("Optimize Your",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  height: 1
              ),),
            Text("Savings.",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                  height: 1
              ),),
            SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Track your expenses, understand your habits, and ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,)
                ),
        Text("make smarter financial decisions.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,)
        ),],),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Thirdpage()),);
            },
              child: Text("Get Started",
                style: TextStyle(
                  fontSize: 20,
                    color: Colors.white
                ),),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(400, 60),
                  backgroundColor: Colors.black),)
          ],
        ),
      ),

    );
  }
}







