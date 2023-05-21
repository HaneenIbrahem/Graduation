// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:new_design/constant/firebase_consts.dart';
// import 'package:new_design/widgets/text_widget.dart';
// import 'package:uuid/uuid.dart';

// class GlobalMethods {
//   // static navigateTo({required BuildContext ctx, required String routeName}) {
//   //   Navigator.pushNamed(ctx, routeName);
//   // }

//   static Future<void> warningDialog({
//     required String title,
//     required String subTitle,
//     required Function fct,
//     required BuildContext context,
//   }) async {
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Row(
//             children: [
//               Image.asset(
//                 'assets/images/warning-sign.png',
//                 height: 20,
//                 width: 20,
//                 fit: BoxFit.fill,
//               ),
//               const SizedBox(
//                 width: 8,
//               ),
//               Text(title),
//             ],
//           ),
//           content: Text(subTitle),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 if (Navigator.canPop(context)) {
//                   Navigator.pop(context);
//                 }
//               },
//               child: TextWidget(
//                 color: Colors.cyan,
//                 text: 'Cancel',
//                 textSize: 18,
//                 fontFamily: 'times-new-roman',
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 fct();
//                 Navigator.canPop(context) ? Navigator.of(context).pop() : null;
//               },
//               child: TextWidget(
//                 fontFamily: 'times-new-roman',
//                 color: Colors.red,
//                 text: 'OK',
//                 textSize: 18,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   static Future<void> errorDialog({
//     required String subTitle,
//     required BuildContext context,
//   }) async {
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Row(
//             children: [
//               Image.asset(
//                 'assets/images/warning-sign.png',
//                 height: 20,
//                 width: 20,
//                 fit: BoxFit.fill,
//               ),
//               const SizedBox(
//                 width: 8,
//               ),
//               const Text("An Error occured"),
//             ],
//           ),
//           content: Text(subTitle),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 if (Navigator.canPop(context)) {
//                   Navigator.pop(context);
//                 }
//               },
//               child: TextWidget(
//                 fontFamily: 'times-new-roman',
//                 color: Colors.cyan,
//                 text: 'Ok',
//                 textSize: 18,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   static Future<void> addToCart({
//     required String productId,
//     required int quantity,
//     required BuildContext context,
//   }) async {
//     final User? user = authInstance.currentUser;
//     final uid = user!.uid;
//     final cartId = const Uuid().v4();
//     try {
//       await FirebaseFirestore.instance.collection('users').doc(uid).update({
//         'userCart': FieldValue.arrayUnion([
//           {
//             'cartId': cartId,
//             'productId': productId,
//             'quantity': quantity,
//           }
//         ]),
//       });
//       await Fluttertoast.showToast(
//         msg: 'Item has been added to your cart',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.grey.shade600,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     } catch (error) {
//       errorDialog(subTitle: '$error', context: context);
//     }
//   }

//   static Future<void> addToWishlist({
//     required String productId,
//     required BuildContext context,
//   }) async {
//     final User? user = authInstance.currentUser;
//     final uid = user!.uid;
//     final wishlistId = const Uuid().v4();
//     try {
//       await FirebaseFirestore.instance.collection('users').doc(uid).update({
//         'userWish': FieldValue.arrayUnion([
//           {
//             'wishlistId': wishlistId,
//             'productId': productId,
//           }
//         ]),
//       });
//       // TODO: Refactor the flutter toast to be in a widget and use it
//       await Fluttertoast.showToast(
//         msg: 'Item has been added to your wishlist',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.grey.shade600,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     } catch (error) {
//       errorDialog(subTitle: '$error', context: context);
//     }
//   }
// }
