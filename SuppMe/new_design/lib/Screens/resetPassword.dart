import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/login.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../widgets/text_widget.dart';

class ResetPassword extends StatefulWidget {
  late String email;
  ResetPassword({Key? key, required this.email}) : super(key: key);
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> formstate = GlobalKey();
  final password = TextEditingController();
  final confpassword = TextEditingController();

  Future<dynamic> resetPass(String password, String email) async {
    Response response = await post(
        Uri.parse("https://doniaserver1.000webhostapp.com/reset_password.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }));
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());
    if (jsonResponse['status'] == "success") {
      print("Success: " + jsonResponse['message'].toString());
    }

    return jsonResponse;
  }

  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  // @override
  // void initState() {
  //   _passwordVisible = false;
  // }
  void _togglevisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _togglevisibility2() {
    setState(() {
      _passwordVisible2 = !_passwordVisible2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      // backgroundColor: const Color.fromARGB(235, 245, 245, 245),
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
      //   elevation: 0.0,
      //   title: Text('Forget Password',
      //       style: Theme.of(context).textTheme.headline5!.copyWith(
      //             color: Color.fromARGB(255, 90, 96, 105),
      //           )),
      // ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: ListView(
            children: [
              const SizedBox(height: 100),
              Text("Reset Password",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontFamily: 'times-new-roman',
                      )),
              // const SizedBox(height: 55),
              Image.asset(
                'assets/SubMee.png',
                height: 200,
                width: 200,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Please enter your new password ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: const Color.fromARGB(255, 122, 129, 139),
                        fontFamily: 'times-new-roman',
                      ),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: password,
                obscureText: !_passwordVisible,
                style: const TextStyle(
                  color: Color.fromARGB(255, 90, 96, 105),
                ),
                decoration: InputDecoration(
                  hintText: "enter your password",
                  hintStyle: const TextStyle(fontSize: 14),
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
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color.fromARGB(255, 90, 96, 105),
                    ),
                    onPressed: () {
                      _togglevisibility();
                    },
                  ),
                  // fillColor: const Color.fromRGBO(30, 30, 30, .51),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: confpassword,
                obscureText: !_passwordVisible2,
                style: const TextStyle(
                  color: Color.fromARGB(255, 90, 96, 105),
                ),
                decoration: InputDecoration(
                  hintText: "confirm password",
                  hintStyle: const TextStyle(fontSize: 14),
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
                      _passwordVisible2
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color.fromARGB(255, 90, 96, 105),
                    ),
                    onPressed: () {
                      _togglevisibility2();
                    },
                  ),
                  // fillColor: const Color.fromRGBO(30, 30, 30, .51),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 00.0),
                child: Container(
                  width: 209,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 90, 96, 105),
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
                      if (password.text!.isEmpty || password.text.length < 8) {
                        print("Please, enter a valid password");
                        warningDialog(
                            title: "Error",
                            subTitle: "Please, enter a valid password",
                            context: context);
                        return;
                      }
                      if (!(password.text! == confpassword.text)) {
                        print("Password does not match");
                        warningDialog(
                            title: "Error",
                            subTitle: "Passwords do not match",
                            context: context);
                        return;
                      }
                      resetPass(password.text, widget.email);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 115),
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
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
          )),
    );
  }
}

Future warningDialog({
  required String title,
  required String subTitle,
  // required Function fct,
  required BuildContext context,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Image.asset(
              'assets/warning-sign.png',
              height: 20,
              width: 20,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(title),
          ],
        ),
        content: Text(subTitle),
        actions: [
          // TextButton(
          //   onPressed: () {
          //     if (Navigator.canPop(context)) {
          //       Navigator.pop(context);
          //     }
          //   },
          //   // child: TextWidget(
          //   //   fontFamily: 'times-new-roman',
          //   //   color: Colors.cyan,
          //   //   text: 'Cancel',
          //   //   textSize: 18,
          //   // ),
          // ),
          TextButton(
            onPressed: () {
              // fct();
              Navigator.canPop(context) ? Navigator.of(context).pop() : null;
            },
            child: TextWidget(
              fontFamily: 'times-new-roman',
              color: Colors.red,
              text: 'OK',
              textSize: 18,
            ),
          ),
        ],
      );
    },
  );
}
