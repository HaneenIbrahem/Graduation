import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:new_design/Screens/bottomBarScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'signup.dart';

// var fbm =FirebaseMessaging.instance;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Future<void> _checkLoginStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final isLoggedIn = prefs.getBool('isLoggedIn');
  //   final name = prefs.getString('name');
  //   final email = prefs.getString('email');
  //   final id = prefs.getString('id');
  //   final address = prefs.getString('address');
  //   print("/***************************************/");
  //   print(id);
  //   if (isLoggedIn != null && isLoggedIn) {
  //     // Navigator.pushReplacementNamed(context, '/home');
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //         builder: (context) => BottomBarScreen(
  //               id: id,
  //               address: address,
  //               email: email,
  //               name: name,
  //             )));
  //   } else {
  //     // Navigator.pushReplacementNamed(context, '/login');
  //     Navigator.of(context)
  //         .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  //   }
  // }

  // Future<String?> _idinfo() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   final id = prefs.getString('id');
  //   return id;
  // }

  @override
  void initState() {
    super.initState();
    // _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // buildbackgroundimage(),
            // Center(
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome To SuppMe',
                    style: TextStyle(
                      color: Color.fromARGB(255, 62, 90, 116),
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico-Regular',
                    ),
                  ),
                  // Image(image: AssetImage('assets/SubMe.png')),
                  const SizedBox(height: 30),
                  Image.asset(
                    'assets/SubMee.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 60),
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
                              Color.fromARGB(255, 51, 66, 73)
                              // Color.fromRGBO(204, 0, 204, 1),
                              // Color.fromRGBO(255, 0, 255, 1)
                            ]),
                      ),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        onPressed: () {
                          // await fbm.getToken().then((value) {
                          //   print(fbm);
                          // });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
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
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 00.0),
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
                              Color.fromARGB(255, 51, 66, 73)
                              // Color.fromRGBO(204, 0, 204, 1),
                              // Color.fromRGBO(255, 0, 255, 1)
                            ]),
                      ),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 35.0),
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
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
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Widget buildbackgroundimage() => Container(
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//         image: AssetImage('assets/1.jpeg'),
//         fit: BoxFit.cover,
//       )),
//     );
