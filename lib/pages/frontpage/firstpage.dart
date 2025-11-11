import "package:expense_tracker/util/bottomnavbar.dart";
import "package:flutter/material.dart";


class Firstpage extends StatelessWidget {
  const Firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: (){
          Navigator.push(
              context,
          MaterialPageRoute(builder:
              (context) => Bottomnavbar()),
          );
        },
            child: Text("Home Page")),
      ),
    );
  }
}
