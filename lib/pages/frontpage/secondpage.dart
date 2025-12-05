import 'package:expense_tracker/pages/frontpage/thirdpage.dart';
import 'package:flutter/material.dart';

class Secondpage extends StatelessWidget {
  const Secondpage({super.key});

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
            vertical: height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("TrackIT.",
            style: TextStyle(
                fontSize: width*0.05,
                fontWeight: FontWeight.w500
            ),
          ),
            SizedBox(height: height*0.05,),
            Image.asset("assets/secondpage.jpg",
              width:width*0.9,
              height:height*0.4,),
            Spacer(),
            Text("Visualize Your ",
              style: TextStyle(
                  fontSize: width*0.1,
                  fontWeight: FontWeight.bold,
                  height: 1
              ),),
            Text("Spending.",
              style: TextStyle(
                  fontSize: width*0.1,
                  fontWeight: FontWeight.bold,
                  height: 1
              ),),
            Text("Optimize Your",
              style: TextStyle(
                  fontSize: width*0.1,
                  fontWeight: FontWeight.bold,
                  height: 1
              ),),
            Text("Savings.",
              style: TextStyle(
                  fontSize: width*0.1,
                  fontWeight: FontWeight.bold,
                  height: 1
              ),),
            SizedBox(height: height*0.02,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Track your expenses, understand your habits, and ",
                  style: TextStyle(
                    fontSize: width*0.0352,
                    color: Color(0xFF808080),)
                ),
        Text("make smarter financial decisions.",
            style: TextStyle(
              fontSize: width*0.0352,
              color: Color(0xFF808080),)
        ),],),
            SizedBox(height: height*0.02,),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Thirdpage()),);
            },
              child: Text("Get Started",
                style: TextStyle(
                    fontSize: width*0.04,
                    color: Colors.white
                ),),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(width*0.9, height*0.06),
                  backgroundColor: Colors.black),)
          ],
        ),
      ),

    );
  }
}







