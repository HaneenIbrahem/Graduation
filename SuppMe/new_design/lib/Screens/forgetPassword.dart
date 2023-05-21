import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/verify.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../widgets/text_widget.dart';

class ForgetPassword extends StatelessWidget {
  // final String? emel;
  ForgetPassword({Key? key}) : super(key: key);
  // late final email = TextEditingController();
  TextEditingController email = TextEditingController();
  // @override
  // void initState() {
  //   print("object + hello");
  //   print(emel);
  //   print("object");
  //   print(email);
  // }

  Future<dynamic> checkEmail(String email) async {
    Response response = await post(
        Uri.parse("https://doniaserver1.000webhostapp.com/forget_password.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email}));

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());
    if (jsonResponse['status'] == "success") {
      debugPrint("Success: " + jsonResponse['message'].toString());
      // this.email = jsonResponse['message']['email'];
    }
    return jsonResponse;
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      // backgroundColor: Color.fromARGB(235, 245, 245, 245),
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
              const SizedBox(height: 50),
              Text("Forget password",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontFamily: 'times-new-roman',
                      )),
              const SizedBox(height: 20),
              Image.asset(
                'assets/SubMee.png',
                height: 180,
                width: 180,
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Please enter your email to resive a verification code",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Color.fromARGB(255, 122, 129, 139),
                        fontFamily: 'times-new-roman',
                      ),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                style: const TextStyle(
                  color: Color.fromARGB(255, 90, 96, 105),
                ),
                decoration: InputDecoration(
                  hintText: "enter your email",
                  hintStyle: TextStyle(fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 0.2,
                      // color: Color.fromRGBO(52, 52, 52, 1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: GradientOutlineInputBorder(
                    width: 1.3,
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
              ),
              const SizedBox(height: 30),
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
                    borderRadius: BorderRadius.circular(20),
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () async {
                      if (email.text!.isEmpty || !email.text.contains("@")) {
                        print("Please, enter a valid email");
                        warningDialog(
                            title: "Error",
                            subTitle: "Please, enter a valid email",
                            context: context);
                        return;
                      }

                      // if (email.text != emel) {
                      //   print("Please, enter a valid email");
                      //   warningDialog(
                      //       title: "Error",
                      //       subTitle: "Please, enter a valid email",
                      //       context: context);
                      //   return;
                      // }
                      var y = await checkEmail(email.text);
                      if (y['status'] == "fail") {
                        print(y['message']);
                        warningDialog(
                            title: "Error",
                            subTitle: y['message'],
                            context: context);
                        return;
                      }
                      // print('hihihihihihi');
                      // print(y['message']);
                      // print('hehehehehehe');
                      Fluttertoast.showToast(
                        msg: 'An email has been sent to your email address',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey.shade600,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Verify(email: email.text)));
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 100.0),
                          child: Text(
                            'Check',
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
