import 'package:expense_tracker/pages/frontpage/signinpage.dart';
import 'package:expense_tracker/util/bottomnavbar.dart';
import 'package:flutter/material.dart';

import '../homepage.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(height: 60,),
            Text("Get started with TrackIT",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 5,),
            Text("Create a secure account in just a few steps",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email",
                    style: TextStyle(
                      fontSize: 15,
                    ),),
                  SizedBox(height: 5,),
                  TextField(
                    decoration: InputDecoration(
                      // labelText: 'Email',
                        hintText: "Enter email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                  ),
                  SizedBox(height: 22,),
                  Text("Password",
                    style: TextStyle(
                      fontSize: 15,
                    ),),
                  SizedBox(height: 5,),
                  TextField(
                    decoration: InputDecoration(
                      // labelText: 'Password',
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                  ),

                  SizedBox(height: 3,),
                  Padding(
                    padding: const EdgeInsets.only(left: 236.0),
                    child: TextButton(onPressed: (){}, child: Text("Forgot Password?")),
                  )
                ],
              ),
            ),
            // SizedBox(height: 5,),
            ElevatedButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> Bottomnavbar()));
            }, child: Text("Log In",
              style: TextStyle(
                  color: Colors.white,
                fontSize: 18
              ),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(342, 53),
                backgroundColor: Colors.black,
              ),),
            SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),),
                TextButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> Signinpage()));
                }, child: Text("Register",style: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.w400
                ),))
              ],
            )

          ],
        ),
      ),
    );
  }
}
