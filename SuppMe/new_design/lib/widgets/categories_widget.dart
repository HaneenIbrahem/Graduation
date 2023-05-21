// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:new_design/Screens/Categories.dart';
// import 'package:new_design/widgets/text_widget.dart';
// // import 'package:grocery_app/inner_screens/cat_screen.dart';
// // import 'package:grocery_app/widgets/text_widget.dart';
// import 'package:provider/provider.dart';

// import '../Screens/productDetails.dart';
// import '../provider/dark_theme_provider.dart';

// // import '../provider/dark_theme_provider.dart';

// class CategoriesWidget extends StatelessWidget {
//   const CategoriesWidget(
//       {Key? key,
//       required this.catText,
//       required this.imgPath,
//       required this.passedColor})
//       : super(key: key);
//   final String catText, imgPath;
//   final Color passedColor;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final themeState = Provider.of<DarkThemeProvider>(context);
//     double screenWidth = MediaQuery.of(context).size.width;
//     final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
// //     List<String> myList = [];
// // myList[0] = catText;
// // myList[1] = userId;
//     return InkWell(
//       onTap: () {
//         // Navigator.pushNamed(
//         //   context,
//         //   Categories.routeName,
//         //   arguments: catText,
//         // );
//       },
//       child: Container(
//         // height: screenWidth * 0.6,
//         decoration: BoxDecoration(
//           color: passedColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: passedColor.withOpacity(0.7),
//             width: 2,
//           ),
//         ),
//         child: Column(
//           children: [
//             // Container for the image
//             Container(
//               height: screenWidth * 0.4,
//               width: screenWidth * 0.4,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(
//                     imgPath,
//                   ),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//             // Category name
//             TextWidget(
//               fontFamily: 'times-new-roman',
//               text: catText,
//               color: color,
//               textSize: 20,
//               isTitle: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
