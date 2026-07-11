import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, top: 60),
              height: 100,
              width: 440,
              padding: EdgeInsets.only(left: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle_sharp, size: 60),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kirthi Shetty",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "kirthishetty20156@gmail.com",
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
                  ElevatedButton(onPressed: () {}, child: Text("Edit")),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.redAccent.shade400,
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 100,
              width: 440,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 25),
                  Icon(Icons.workspace_premium, color: Colors.white, size: 60),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "For Premium",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Get our premium features",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(width: 80),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                "Account Settings",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.shade300,
              ),
              height: 260,
              width: 400,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // color: Colors.white,
                      height: 50,
                      width: 360,
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_sharp),
                          SizedBox(width: 30),
                          Text(
                            "Account Information",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 60),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      // color: Colors.white,
                      height: 50,
                      width: 360,
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_sharp),
                          SizedBox(width: 30),
                          Text(
                            "Edit fixed expenses",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 70),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      // color: Colors.white,
                      height: 50,
                      width: 360,
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_sharp),
                          SizedBox(width: 30),
                          Text(
                            "Change Password",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 82),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.shade300,
              ),
              height: 290,
              width: 400,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // color: Colors.white,
                      height: 50,
                      width: 360,
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_sharp),
                          SizedBox(width: 30),
                          Text(
                            "Account Information",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 56),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      // color: Colors.white,
                      height: 50,
                      width: 360,
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_sharp),
                          SizedBox(width: 30),
                          Text(
                            "Manage fixed expenses",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 30),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      // color: Colors.white,
                      height: 50,
                      width: 360,
                      child: Row(
                        children: [
                          Icon(Icons.account_circle_sharp),
                          SizedBox(width: 30),
                          Text(
                            "Log out",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 175),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
