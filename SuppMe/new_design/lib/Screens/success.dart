import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login.dart';

// class Success extends StatefulWidget {
//   Success({Key? key}) : super(key: key);
//   @override
//   State<Success> createState() => _SuccessState();
// }

// class _SuccessState extends State<Success> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Center(
//             child: Text("account created successfully"),
//           ),
//           MaterialButton(
//               textColor: Color.fromARGB(100, 100, 100, 100),
//               color: Colors.blue,
//               onPressed: () {},
//               child: Text("Log in"))
//         ],
//       ),
//     );
//   }
// }
/************************************************* */

class Success extends StatelessWidget {
  Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80),
          Image.asset(
            'assets/SubMee.png',
            // height: 400,
            // width: 400,
          ),
          const SizedBox(height: 60),
          Column(
            children: [
              Center(
                child: AnimatedTextKit(animatedTexts: [
                  TyperAnimatedText('Account created successfully',
                      textStyle: TextStyle(
                        fontSize: 30,
                        color: Colors.amber,
                        // color: Color.fromARGB(255, 12, 160, 140),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'times-new-roman',
                      )),
                ], repeatForever: false),
              ),
            ],
          ),
          // MaterialButton(onPressed: () {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => Login()));
          // }),
          const SizedBox(height: 90),
          // Padding(
          //   padding: const EdgeInsets.only(
          //       left: 15.0, right: 15.0, top: 70, bottom: 10),
          // child: buldbuttonsuccess(),
          Padding(
            padding: const EdgeInsets.only(right: 00.0),
            child: Container(
              width: 209,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 90, 96, 105),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 80, 160, 180),
                      Color.fromARGB(255, 80, 160, 180)
                      // Color.fromRGBO(204, 0, 204, 1),
                      // Color.fromRGBO(255, 0, 255, 1)
                    ]),
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Login()));
                  // Navigator.of(context)
                  //     .pushNamedAndRemoveUntil("login", (route) => false);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Login()));
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'times-new-roman',
                        ),
                      ),
                    ),
                    // Icon(
                    //   Icons.keyboard_arrow_right,
                    //   size: 40,
                    //   color: Colors.white,
                    // ),
                  ],
                ),
              ),
            ),
          ),
          // ),
        ],
      ),
    );
  }
}

Widget buldbuttonsuccess() => Container(
      width: 190,
      height: 70,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 80, 160, 180),
              Color.fromARGB(255, 51, 66, 73)
            ]),
        borderRadius: BorderRadius.circular(22),
      ),
      child: MaterialButton(
        onPressed: () async {
          await Success();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        // splashColor: const Color.fromRGBO(30, 30, 30, .51),
        child: const Text(
          'Sign up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'times-new-roman',
          ),
        ),
      ),
    );
