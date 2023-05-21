import 'dart:convert';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/home.dart';
import 'package:new_design/Screens/loading_manager.dart';
import 'package:new_design/Screens/mainPage.dart';
import 'package:new_design/Screens/success.dart';
import 'package:new_design/components/create_raed_update_delete.dart';
import 'package:new_design/constant/linkapi.dart';
import '../services/utils.dart';
import '../widgets/text_widget.dart';
import 'bottomBarScreen.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

// class _SignUpState extends State<SignUp>{
// }

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
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

  // Crud _crud = Crud();
  // late String birthDateInString;
  // late DateTime birthDate;

  // bool isDateSelected = false;
  bool _isLoading = false;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confpass = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  // TextEditingController _gender = TextEditingController();
  TextEditingController _birthdate = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _address.dispose();
    _confpass.dispose();
    _birthdate.dispose();
    super.dispose();
  }

  // signUp() async {
  //   // if (formstate.currentState!.validate()) {}
  //   _isLoading = true;
  //   setState(() {});
  //   var responce = await _crud.postRequest(linkSignup, {
  //     "name": name.text,
  //     "email": email.text,
  //     "password": password.text,
  //     "phone": phone.text,
  //     "gender": gender.text,
  //     "birthdate": birthdate.text
  //   });
  //   _isLoading = false;
  //   setState(() {});
  //   if (responce['status'] == "success") {
  //     // print("succccccesssss");
  //     // Navigator.push(
  //     //     context, MaterialPageRoute(builder: (context) => Success()));
  //     Navigator.of(context)
  //         .pushNamedAndRemoveUntil("success", (route) => false);
  //   } else {
  //     print("signup fail");
  //   }
  // }

  Future<dynamic> signupToBackend(String name, String email, String address,
      String password, String birthdate) async {
    Response response = await post(
        Uri.parse("https://doniaserver1.000webhostapp.com/singup.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'address': address,
          // 'gender': gender,
          'birthdate': birthdate,
          'password': password
        }));
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());
    if (jsonResponse['status'] == "success") {
      print("Success: " + jsonResponse['message'].toString());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Success(),
        ),
      );
      // this.id = jsonResponse['message']['id'].toString();
      // this._name = jsonResponse['message']['name'];
      // this._email = jsonResponse['message']['email'];
      // this._phone = jsonResponse['message']['phone'];
      // // this._gender = jsonResponse['message']['gender'];
      // this._birthdate = jsonResponse['message']['birthdate'];
      // this._password = jsonResponse['message']['password'];
    }

    return jsonResponse;
  }

  @override
  Widget build(BuildContext context) {
    String? gender;
    // int selectedValue = 0;
    final Color color = Utils(context).color;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: LoadingManager(
          isLoading: _isLoading,
          // Center(child: CircularProgressIndicator())
          child: Stack(
            children: [
              // backgroundimage(),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // const SizedBox(height: 20),
                      // head(),
                      Image.asset(
                        'assets/SubMee.png',
                        height: 150,
                        width: 150,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 18.5,
                                  color: Color.fromARGB(255, 90, 96, 105),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            buildname(_name),
                            const SizedBox(height: 8),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 18.5,
                                  color: Color.fromARGB(255, 90, 96, 105),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            buildemail(_email),
                            const SizedBox(height: 8),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 18.5,
                                  color: Color.fromARGB(255, 90, 96, 105),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              // obscureText: true,
                              controller: _password,
                              obscureText: !_passwordVisible,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 90, 96, 105)),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 17.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 0.2,
                                    // color: Color.fromRGBO(52, 52, 52, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: GradientOutlineInputBorder(
                                  width: 1.3,
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromARGB(255, 80, 160, 180),
                                        Color.fromARGB(255, 51, 66, 73)
                                      ]),
                                ),
                                prefixIcon: const Icon(Icons.lock,
                                    color: Color.fromARGB(255, 90, 96, 105)),
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
                            const SizedBox(height: 8),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'Confirm password',
                                style: TextStyle(
                                  fontSize: 18.5,
                                  color: Color.fromARGB(255, 90, 96, 105),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              // obscureText: true,
                              controller: _confpass,
                              obscureText: !_passwordVisible2,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 90, 96, 105)),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 17.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 0.2,
                                    // color: Color.fromRGBO(52, 52, 52, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: GradientOutlineInputBorder(
                                  width: 1.3,
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromARGB(255, 80, 160, 180),
                                        Color.fromARGB(255, 51, 66, 73)
                                      ]),
                                ),
                                prefixIcon: const Icon(Icons.lock,
                                    color: Color.fromARGB(255, 90, 96, 105)),
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
                            const SizedBox(height: 8),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'Address',
                                style: TextStyle(
                                  fontSize: 18.5,
                                  color: Color.fromARGB(255, 90, 96, 105),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            buildaddress(_address),
                            const SizedBox(height: 8),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'Birth date ',
                                style: TextStyle(
                                  fontSize: 18.5,
                                  color: Color.fromARGB(255, 90, 96, 105),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            // Column(
                            //   children: [
                            //     ListTile(
                            //         title: const Text(
                            //           "Male",
                            //           style: TextStyle(
                            //               fontFamily: 'times-new-roman',
                            //               fontSize: 18,
                            //               color:
                            //                   Color.fromARGB(255, 90, 96, 105)),
                            //         ),
                            //         leading: Radio(
                            //           value: "Male",
                            //           groupValue: gender,
                            //           onChanged: (value) {
                            //             setState(() {
                            //               gender = value.toString();
                            //               print(gender);
                            //             });
                            //           },
                            //         )),
                            //     RadioListTile(
                            //       // tileColor: Colors.yellow,
                            //       activeColor: Colors.green,
                            //       title: const Text(
                            //         "Female",
                            //         style: TextStyle(
                            //             fontFamily: 'times-new-roman',
                            //             fontSize: 18,
                            //             color:
                            //                 Color.fromARGB(255, 90, 96, 105)),
                            //       ),

                            //       value: "Female",
                            //       groupValue: gender,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           gender = value.toString();
                            //           print(gender);
                            //         });
                            //       },
                            //     ),
                            //   ],
                            // ),

                            TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 17.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 0.2,
                                      // color: Color.fromRGBO(52, 52, 52, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: GradientOutlineInputBorder(
                                    width: 1.3,
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color.fromARGB(255, 80, 160, 180),
                                          Color.fromARGB(255, 51, 66, 73)
                                        ]),
                                  ),
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 90, 96, 105)),
                                  prefixIcon: const Icon(Icons.calendar_today,
                                      color: Color.fromARGB(255, 90, 96, 105)),
                                  filled: true,
                                  // fillColor: const Color.fromRGBO(30, 30, 30, .51),
                                ),
                                controller:
                                    _birthdate, //editing controller of this TextField
                                readOnly:
                                    true, // when true user cannot edit text

                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          DateTime.now(), //get today's date
                                      firstDate: DateTime(
                                          1960), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime.now());
                                  if (pickedDate != null) {
                                    String formatedDate =
                                        DateFormat("yyyy-MM-dd")
                                            .format(pickedDate);
                                    setState(() {
                                      _birthdate.text = formatedDate.toString();
                                    });
                                  } else {
                                    print("not selected");
                                  }
                                  //when click we have to show the datepicker
                                }),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(right: 00.0),
                        child: Container(
                          width: 209,
                          height: 55,
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
                              print("hi");
                              if (_name.text!.isEmpty) {
                                print("Name field is missing");
                                warningDialog(
                                    title: "Error",
                                    subTitle: "Name field is missing",
                                    context: context);
                                return;
                              }
                              if (_email.text!.isEmpty ||
                                  !_email.text.contains("@")) {
                                print("Please, enter a valid email");
                                warningDialog(
                                    title: "Error",
                                    subTitle: "Please, enter a valid email",
                                    context: context);
                                return;
                              }
                              if (_password.text!.isEmpty ||
                                  _password.text.length < 8) {
                                print("Please, enter a valid password");
                                warningDialog(
                                    title: "Error",
                                    subTitle: "Please, enter a valid password",
                                    context: context);
                                return;
                              }
                              if (!(_password.text! == _confpass.text)) {
                                print("Password does not match");
                                warningDialog(
                                    title: "Error",
                                    subTitle: "Passwords do not match",
                                    context: context);
                                return;
                              }
                              if (_address.text!.isEmpty) {
                                print("Missimg address field ");
                                warningDialog(
                                    title: "Error",
                                    subTitle: "Missimg address field ",
                                    context: context);
                                return;
                              }
                              if (_birthdate.text!.isEmpty) {
                                print("Birthdate field is missing");
                                warningDialog(
                                    title: "Error",
                                    subTitle: "Birthdate field is missing",
                                    context: context);
                                return;
                              }

                              // if (_formKey.currentState!.validate()) {
                              await signupToBackend(
                                  _name.text,
                                  _email.text.toLowerCase(),
                                  _address.text,
                                  _password.text,
                                  // _gender.text,
                                  _birthdate.text);

                              // }
                            },
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 40.0),
                                  child: Text(
                                    'Sign up',
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

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Widget buildemail(var email) => TextFormField(
      // validator: (value) {
      //   if (value!.isEmpty || !value.contains("@")) {
      //     return "Please, enter a valid email address";
      //   } else {
      //     return null;
      //   }
      // },
      keyboardType: TextInputType.emailAddress,
      controller: email,
      style: const TextStyle(
        color: Color.fromARGB(255, 90, 96, 105),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 17.0),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.2,
            // color: Color.fromRGBO(52, 52, 52, 1),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: GradientOutlineInputBorder(
          width: 1.3,
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 80, 160, 180),
                Color.fromARGB(255, 51, 66, 73)
              ]),
        ),
        prefixIcon: const Icon(Icons.email_rounded,
            color: Color.fromARGB(255, 90, 96, 105)),
        filled: true,
        // fillColor: const Color.fromRGBO(30, 30, 30, .51),
      ),
    );
Widget buildaddress(var address) => TextFormField(
      keyboardType: TextInputType.streetAddress,
      controller: address,
      style: const TextStyle(color: Color.fromARGB(255, 90, 96, 105)),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 17.0),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.2,
            // color: Color.fromRGBO(52, 52, 52, 1),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: GradientOutlineInputBorder(
          width: 1.3,
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 80, 160, 180),
                Color.fromARGB(255, 51, 66, 73)
              ]),
        ),
        prefixIcon: const Icon(Icons.location_on,
            color: Color.fromARGB(255, 90, 96, 105)),
        filled: true,
        // fillColor: const Color.fromRGBO(30, 30, 30, .51),
      ),
    );

// Widget buildpass(var pass) => TextFormField(
//       // validator: (value) {
//       //   if (value!.isEmpty || value.length < 7) {
//       //     return "Please, enter a valid password";
//       //   } else {
//       //     return null;
//       //   }
//       // },
//       keyboardType: TextInputType.visiblePassword,
//       obscureText: true,
//       controller: pass,
//       style: const TextStyle(color: Color.fromARGB(255, 90, 96, 105)),
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.symmetric(vertical: 17.0),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(
//             width: 0.2,
//             // color: Color.fromRGBO(52, 52, 52, 1),
//           ),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         focusedBorder: GradientOutlineInputBorder(
//           width: 1.3,
//           borderRadius: BorderRadius.circular(15),
//           gradient: const LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color.fromARGB(255, 80, 160, 180),
//                 Color.fromARGB(255, 51, 66, 73)
//               ]),
//         ),
//         prefixIcon:
//             const Icon(Icons.lock, color: Color.fromARGB(255, 90, 96, 105)),
//         filled: true,
//         suffixIcon: IconButton(
//                     icon: Icon(
//                       // Based on passwordVisible state choose the icon
//                       _passwordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: Color.fromARGB(255, 90, 96, 105),
//                     ),
//                     onPressed: () {
//                       _togglevisibility();
//                     },
//                   ),
//         // fillColor: const Color.fromRGBO(30, 30, 30, .51),
//       ),
//     );
// Widget buildconfpass(var confpass) => TextFormField(
//       keyboardType: TextInputType.visiblePassword,
//       obscureText: true,
//       controller: confpass,
//       style: const TextStyle(color: Color.fromARGB(255, 90, 96, 105)),
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.symmetric(vertical: 17.0),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(
//             width: 0.2,
//             // color: Color.fromRGBO(52, 52, 52, 1),
//           ),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         focusedBorder: GradientOutlineInputBorder(
//           width: 1.3,
//           borderRadius: BorderRadius.circular(15),
//           gradient: const LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color.fromARGB(255, 80, 160, 180),
//                 Color.fromARGB(255, 51, 66, 73)
//               ]),
//         ),
//         prefixIcon:
//             const Icon(Icons.lock, color: Color.fromARGB(255, 90, 96, 105)),
//         filled: true,
//         suffixIcon: IconButton(
//                     icon: Icon(
//                       // Based on passwordVisible state choose the icon
//                       _passwordVisible2
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: Color.fromARGB(255, 90, 96, 105),
//                     ),
//                     onPressed: () {
//                       _togglevisibility2();
//                     },
//                   ),
//         // fillColor: const Color.fromRGBO(30, 30, 30, .51),
//       ),
//     );

Widget buildname(var name) => TextFormField(
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return "This field is missing";
      //   } else {
      //     return null;
      //   }
      // },
      keyboardType: TextInputType.name,
      controller: name,
      style: const TextStyle(color: Color.fromARGB(255, 90, 96, 105)),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 17.0),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.2,
            // color: Color.fromRGBO(52, 52, 52, 1),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: GradientOutlineInputBorder(
          width: 1.3,
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 80, 160, 180),
                Color.fromARGB(255, 51, 66, 73)
              ]),
        ),
        prefixIcon:
            const Icon(Icons.person, color: Color.fromARGB(255, 90, 96, 105)),
        filled: true,
        // fillColor: const Color.fromRGBO(30, 30, 30, .51),
      ),
    );

// Widget buldbuttonregister() => Container(
//       width: 190,
//       height: 70,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color.fromARGB(255, 80, 160, 180),
//               Color.fromARGB(255, 51, 66, 73)
//             ]),
//         borderRadius: BorderRadius.circular(22),
//       ),
//       child: MaterialButton(
//         onPressed: () async {
//           // await signUp();
//         },
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         // splashColor: const Color.fromRGBO(30, 30, 30, .51),
//         child: const Text(
//           'Sign up',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 30.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'times-new-roman',
//           ),
//         ),
//       ),
//     );
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
