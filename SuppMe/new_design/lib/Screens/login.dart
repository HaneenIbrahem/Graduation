import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/admin.dart';
import 'package:new_design/Screens/bottomBarScreen.dart';
// import 'package:new_design/Screens/signup.dart';
import 'package:new_design/Screens/user.dart';
import 'package:new_design/components/create_raed_update_delete.dart';
import 'package:new_design/constant/linkapi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/dark_theme_provider.dart';
import 'forgetPassword.dart';

Future<void> _saveLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
}

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  late String? namee;
  late String? emaill;
  late String? idd;
  late String? address;

  bool _passwordVisible = false;
  void _togglevisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  // Crud crud = Crud();

  // login() async {
  //   // if (formstate.currentState!.validate()) {
  //   var response = await crud.postRequest(
  //       linkLogin, {"email": email.text, "password": password.text});
  //   if (response['state'] == "success") {
  //     Navigator.of(context)
  //         .pushNamedAndRemoveUntil("success", (route) => false);
  //   } else {
  //     AwesomeDialog(
  //         // btnCancel: Text("Cancel"),
  //         context: context,
  //         title: "Warning",
  //         body: Text("error in email or password\n\n\n"))
  //       ..show();
  //   }
  //   // }
  // }

  Future<dynamic> loginToBackend(String email, String password) async {
    Response response = await post(
        Uri.parse("https://doniaserver1.000webhostapp.com/singin.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}));

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());
    if (jsonResponse['status'] == "success") {
      debugPrint("Success: " + jsonResponse['message'].toString());
      this.idd = jsonResponse['message']['id'].toString();
      this.namee = jsonResponse['message']['name'];
      print("hhoo");
      print(namee);
      this.emaill = jsonResponse['message']['email'];
      print(emaill);
      this.address = jsonResponse['message']['address'];
      // this.password = jsonResponse['message']['password'];

    }

    return jsonResponse;
  }

  Future<void> _saveLoginInfo() async {
    // print(
    //     "saving values ID: $idd, Name: $namee, Email: $emaill, Address: $address");
    final prefss = await SharedPreferences.getInstance();
    // await prefs.setBool('isLoggedIn', true);
    await prefss.setString('id', idd!);
    await prefss.setString('name', namee!);
    await prefss.setString('email', emaill!);
    await prefss.setString('address', address!);
    print("Values saved successfully");
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      /// backgroundColor: Color.fromRGBO(58, 0, 95, .81),
      // backgroundColor: Color.fromARGB(235, 245, 245, 245),
      body: Stack(
        children: [
          Container(
              // decoration: const BoxDecoration(
              //     image: DecorationImage(
              //   image: AssetImage('assets/1.jpeg'),
              //   fit: BoxFit.cover,
              // )),
              ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // head(),
                  Image.asset(
                    'assets/SubMee.png',
                    // height: 270,
                    // width: 270,
                  ),
                  // Container(
                  //   padding: const EdgeInsets.only(left: 15),
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     'Log in with one of the following options',
                  //     style: TextStyle(
                  //       color: Colors.black.withOpacity(.5),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //   child: Row(
                  //     children: [
                  //       buildgoogleicon(),
                  //       const SizedBox(width: 30),
                  //       buildappleicon(),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 90, 96, 105),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'times-new-roman',
                            ),
                          ),
                        ),
                        buildemail(),
                        const SizedBox(height: 25),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 90, 96, 105),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'times-new-roman',
                            ),
                          ),
                        ),
                        buildpass(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassword()));
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 139, 133, 133),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 5, bottom: 10),
                  //   child: buldbuttonlogin(),
                  // ),
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
                        onPressed: () async {
                          if (email.text == 'admin' &&
                              password.text == 'admin') {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Admin()),
                              // settings: RouteSettings(arguments: emaill)),
                            );
                          } else {
                            if (email.text!.isEmpty ||
                                !email.text.contains("@")) {
                              print("Please, enter a valid email");
                              warningDialog(
                                  title: "Error",
                                  subTitle: "Please, enter a valid email",
                                  context: context);
                              return;
                            }
                            if (password.text!.isEmpty) {
                              print("Please, enter a valid password");
                              warningDialog(
                                  title: "Error",
                                  subTitle: "Please, enter a valid password",
                                  context: context);
                              return;
                            }
                            var y =
                                await loginToBackend(email.text, password.text);
                            if (y['status'] == "fail") {
                              print(y['message']);
                              // warningDialog(
                              //     title: "Error",
                              //     subTitle: y['message'],
                              //     context: context);
                              return;
                            } else {
                              print(
                                  "saving values ID: $idd, Name: $namee, Email: $emaill, Address: $address");
                              _saveLoginStatus();
                              _saveLoginInfo();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => BottomBarScreen(
                                          name: namee,
                                          email: emaill,
                                          id: idd,
                                          address: address,
                                          // currentIndex: 0,
                                        )),
                                // settings: RouteSettings(arguments: emaill)),
                              );
                            }
                          }
                          print("hi");
                          // print(emaill);
                          // print(namee);
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget head() => Padding(
        padding: const EdgeInsets.only(
          // top: 30,
          bottom: 00.0,
          left: 20.0,
          right: 20.0,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              // height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(70),
                  bottomLeft: Radius.circular(70),
                ),
                // gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [
                //       Color.fromRGBO(128, 0, 128, 1),
                //       Color.fromRGBO(179, 0, 179, 1),
                //       Color.fromRGBO(204, 0, 204, .8)
                //     ]),
              ),
            ),
            const Text(
              'SuppMe',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 62, 90, 116),
                fontFamily: 'Pacifico-Regular',
                fontSize: 50,
              ),
            ),
          ],
        ),
      );

  // Widget buildgoogleicon() => Expanded(
  //       child: Container(
  //         height: 70,
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             width: 2.5,
  //             color: const Color.fromRGBO(52, 52, 52, 1),
  //           ),
  //           borderRadius: BorderRadius.circular(20),
  //           color: const Color.fromRGBO(30, 30, 30, .51),
  //         ),
  //         child: MaterialButton(
  //           elevation: 0,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(22),
  //           ),
  //           onPressed: () {},
  //           child: const Image(
  //             image: AssetImage('assets/white-google-logo.png'),
  //             width: 30,
  //             height: 30,
  //           ),
  //         ),
  //       ),
  //     );

  // Widget buildappleicon() => Expanded(
  //       child: Container(
  //         height: 70,
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             width: 2.5,
  //             color: const Color.fromRGBO(52, 52, 52, 1),
  //           ),
  //           borderRadius: BorderRadius.circular(20),
  //           color: const Color.fromRGBO(30, 30, 30, .51),
  //         ),
  //         child: MaterialButton(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(22),
  //           ),
  //           onPressed: () {},
  //           child: const Icon(
  //             Icons.apple,
  //             size: 40,
  //             color: Colors.black,
  //           ),
  //         ),
  //       ),
  //     );

  Widget buildemail() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: email,
        style: const TextStyle(
          color: Color.fromARGB(255, 90, 96, 105),
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              // color: Color.fromRGBO(52, 52, 52, 1),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: GradientOutlineInputBorder(
            width: 3.0,
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 80, 160, 180),
                  Color.fromARGB(255, 51, 66, 73)
                ]),
          ),
          prefixIcon: const Icon(
            Icons.email_rounded,
            color: Color.fromARGB(255, 90, 96, 105),
          ),
          filled: true,
          // fillColor: const Color.fromRGBO(30, 30, 30, .51),
        ),
      );

  Widget buildpass() => TextFormField(
        keyboardType: TextInputType.visiblePassword,
        style: const TextStyle(
          color: Color.fromARGB(255, 90, 96, 105),
        ),
        controller: password,
        // obscureText: true,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              // color: Color.fromRGBO(52, 52, 52, 1),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: GradientOutlineInputBorder(
            width: 3.0,
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 80, 160, 180),
                  Color.fromARGB(255, 51, 66, 73)
                ]),
          ),
          prefixIcon: const Icon(
            Icons.lock,
            color: Color.fromARGB(255, 90, 96, 105),
          ),
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Color.fromARGB(255, 90, 96, 105),
            ),
            onPressed: () {
              _togglevisibility();
            },
          ),
          // fillColor: const Color.fromRGBO(30, 30, 30, .51),
        ),
      );

  // Widget buldbuttonlogin() => Container(
  //       width: 190,
  //       height: 70,
  //       decoration: BoxDecoration(
  //         color: Color.fromARGB(255, 90, 96, 105),
  //         borderRadius: BorderRadius.circular(22),
  //         gradient: const LinearGradient(
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //             colors: [
  //               Color.fromARGB(255, 80, 160, 180),
  //               Color.fromARGB(255, 51, 66, 73)
  //             ]),
  //       ),
  //       child: MaterialButton(
  //         onPressed: () async {
  //           await login();
  //         },
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(22),
  //         ),
  //         // splashColor: const Color.fromRGBO(30, 30, 30, .51),
  //         child: const Text(
  //           'Log in',
  //           style: TextStyle(
  //             color: Color.fromARGB(255, 255, 255, 255),
  //             fontSize: 30.0,
  //             fontWeight: FontWeight.bold,
  //             fontFamily: 'times-new-roman',
  //           ),
  //         ),
  //       ),
  //     );
}
