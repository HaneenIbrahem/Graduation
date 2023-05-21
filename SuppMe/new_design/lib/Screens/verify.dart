import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/resetPassword.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../widgets/text_widget.dart';

class Verify extends StatelessWidget {
  late String email;
  // late String code;

  // var otpcontroller = List.generate(5, (index) => TextEditingController());
  Verify({Key? key, required this.email}) : super(key: key);
  // final email = TextEditingController();
  Future<dynamic> verifyCode(String email, String code) async {
    Response response = await post(
        Uri.parse("https://doniaserver1.000webhostapp.com/verify_code.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'code': code,
        }));

    var jsonResponse = jsonDecode(response.body);
    print("jsonResponse");
    print(jsonResponse.toString());
    if (jsonResponse['status'] == "success") {
      debugPrint("Success: " + jsonResponse['message'].toString());
      // this.email = jsonResponse['message']['email'];
      // print(email);
      // this.code = jsonResponse['message']['code'];
    }
    return jsonResponse;
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    String msg = "Please enter the digit code send to ";
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
              const SizedBox(height: 100),
              Text("Verification code",
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
                  msg + email,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Color.fromARGB(255, 122, 129, 139),
                        fontFamily: 'times-new-roman',
                      ),
                ),
              ),
              const SizedBox(height: 25),
              OtpTextField(
                // handleControllers: otpcontroller;
                fieldWidth: 50.0,
                borderRadius: BorderRadius.circular(20),
                numberOfFields: 5,
                enabledBorderColor: Color.fromARGB(255, 120, 168, 114),
                // borderColor: Color.fromARGB(255, 168, 49, 49),
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) async {
                  var y = await verifyCode(email, verificationCode);
                  if (y['status'] == "fail") {
                    print(y['message']);
                    warningDialog(
                        title: "Error",
                        subTitle: y['message'],
                        context: context);
                    return;
                  }
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //           title: Text("Verification Code"),
                  //           content: Text("code entered is $verificationCode"));
                  //     });
                  else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword(email: email)));
                  }
                },
              ),

              const SizedBox(height: 30),
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
