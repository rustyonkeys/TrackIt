import "package:expense_tracker/pages/frontpage/secondpage.dart";

import "package:flutter/material.dart";


class Firstpage extends StatelessWidget {
  const Firstpage({super.key});

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
          Image.asset("assets/firstpage.jpg",
            width:width*0.9,
            height:height*0.4,),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Understand Your ",
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
              Text("Unlock Your",
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
                ),)
            ],
          ),
            SizedBox(height: height*0.02,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Take control of your daily expenses and build habits",
                    style: TextStyle(
                      fontSize: width*0.0352,
                      color: Colors.black54,)
                ),
                Text(" that grow your wealth.",
                    style: TextStyle(
                      fontSize: width*0.0352,
                      color: Colors.black54,)
                ),],),
            SizedBox(height:height*0.02,),
            ElevatedButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Secondpage()),);
            },
              child: Text("Next",
                style: TextStyle(
                    fontSize: width*0.04,
                    color: Colors.white
                ),),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                  width*0.9, height*0.06),
                  backgroundColor: Colors.black),)
          ],
        ),
      ),
    );
  }
}



