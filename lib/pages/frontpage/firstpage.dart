import "package:expense_tracker/pages/frontpage/secondpage.dart";

import "package:flutter/material.dart";


class Firstpage extends StatelessWidget {
  const Firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("TrackIT.",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 490,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Understand Your ",
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
              Text("Unlock Your",
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
                ),)
            ],
          ),
            SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Take control of your daily expenses and build habits",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,)
                ),
                Text(" that grow your wealth.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,)
                ),],),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => Secondpage()),);
            },
              child: Text("Next",
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



