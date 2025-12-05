// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// import 'package:expense_tracker/pages/frontpage/firstpage.dart';
// import 'package:expense_tracker/pages/frontpage/secondpage.dart';
// import 'package:expense_tracker/pages/frontpage/thirdpage.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _controller = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: width * 0.08, vertical: height * 0.05),
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView(
//                 controller: _controller,
//                 children: const [
//                   Firstpage(),
//                   Secondpage(),
//                   Thirdpage(),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 SmoothPageIndicator(
//                   controller: _controller,
//                   count: 3,
//                   effect: ExpandingDotsEffect(
//                     dotHeight: 10,
//                     dotWidth: 10,
//                     activeDotColor: Colors.black,
//                     dotColor: Colors.black26,
//                   ),
//                 ),
//                 SizedBox(height: height * 0.02),
//                 SizedBox(
//                   width: width * 0.9,
//                   height: height * 0.065,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_controller.page! < 2) {
//                         _controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
//                       } else {
//                         // Navigate to your app home
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//                     child: Text(
//                       _controller.hasClients && _controller.page == 2 ? "Get Started" : "Next",
//                       style: TextStyle(fontSize: width * 0.05, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
