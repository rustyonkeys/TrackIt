import 'package:expense_tracker/pages/analyticspage.dart';
import 'package:expense_tracker/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {

  int selectedindex = 0;
  PageController pageController = PageController();


  void onTapped(int index) {
    setState(() {
      selectedindex = index;
      pageController.jumpToPage(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          Homepage(),
          AnalyticsPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics')
          ]),
    );
  }
}


// import 'package:expense_tracker/pages/analyticspage.dart';
// import 'package:expense_tracker/pages/homepage.dart';
// import 'package:flutter/material.dart';
//
// class Bottomnavbar extends StatefulWidget {
//   const Bottomnavbar({super.key});
//
//   @override
//   State<Bottomnavbar> createState() => _BottomnavbarState();
// }
//
// class _BottomnavbarState extends State<Bottomnavbar> {
//   int selectedIndex = 0;
//   PageController pageController = PageController();
//
//   void onTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//       pageController.jumpToPage(index);
//     });
//   }
//
//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: pageController,
//         onPageChanged: (index) {
//           setState(() {
//             selectedIndex = index;
//           });
//         },
//         children: [
//           Homepage(),
//           AnalyticsPage(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedIndex,
//         onTap: onTapped,
//         selectedItemColor: Colors.deepPurple,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
//         ],
//       ),
//     );
//   }
// }
