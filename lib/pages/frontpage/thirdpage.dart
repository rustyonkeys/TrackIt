import 'package:flutter/material.dart';

class Thirdpage extends StatelessWidget {
  const Thirdpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 100),
      Text("The Fastest Way",
        style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w500,
            height: 1
          ),
        ),
      Text("To Track Your",
        style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w500,
            height: 1
          ),
        ),
      Text("Expenses.",
        style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w500,
            height: 1
          ),
        ),
      SizedBox(height: 30,),
      
      Row(
        children: [
          ElevatedButton(onPressed: (){}, child: Text("Register Now",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white
          ),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: Size(250,60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
          ),
          SizedBox(width: 5,),
          ElevatedButton(onPressed: (){}, child: Text("Login",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            ),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: Size(133,60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),)
        ],
      )
    ]
    )
      )
    );
  }
}
