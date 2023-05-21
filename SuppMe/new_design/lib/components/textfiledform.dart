// import 'package:flutter/material.dart';
// import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';

// class TextFiledSign extends StatefulWidget {
//   final String hint;
//   final String? Function(String?) valid;
//   final TextEditingController mycontroller;
//   const TextFiledSign(
//       {Key? key,
//       required this.hint,
//       required this.mycontroller,
//       required this.valid})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       child: TextFormField(
//         validator: valid,
//         keyboardType: TextInputType.emailAddress,
//         controller: mycontroller,
//         style: const TextStyle(
//           color: Color.fromARGB(255, 90, 96, 105),
//         ),
//         decoration: InputDecoration(
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               width: 0.5,
//               // color: Color.fromRGBO(52, 52, 52, 1),
//             ),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           focusedBorder: GradientOutlineInputBorder(
//             width: 3.0,
//             borderRadius: BorderRadius.circular(15),
//             gradient: const LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color.fromARGB(255, 80, 160, 180),
//                   Color.fromARGB(255, 51, 66, 73)
//                 ]),
//           ),
//           prefixIcon: const Icon(Icons.email_rounded,
//               color: Color.fromARGB(255, 90, 96, 105)),
//           filled: true,
//           // fillColor: const Color.fromRGBO(30, 30, 30, .51),
//         ),
//       ),
//     );
//   }

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }
