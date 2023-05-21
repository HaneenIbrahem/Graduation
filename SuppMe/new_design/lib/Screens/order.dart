import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'dart:js_util';
import 'package:new_design/Screens/write.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/bottomBarScreen.dart';
import 'package:new_design/Screens/home.dart';
import 'package:new_design/Screens/loading_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_design/Screens/success.dart';

import '../main.dart';
import '../services/utils.dart';
import '../widgets/text_widget.dart';

Future<dynamic> DeleteAllProductsFromCart(
  String userId,
) async {
  Response response = await post(
      Uri.parse(
          "https://doniaserver1.000webhostapp.com/delete_all_from_card.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'user_id': userId}));
  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    print("Success: " + jsonResponse['message'].toString());
  }

  return jsonResponse;
}

String dropdownvalue = 'Fast Delevary';
// List of items in our dropdown menu
var items = ['Fast Delevary', 'Haneen Delevary'];

class OrderScreen extends StatefulWidget {
  final String? userId;
  final String? userName;
  final String? userEmail;
  final String? address;
  final String? total;
  static const String routeName = "/OrderScreen";
  OrderScreen(
      {Key? key,
      this.userId,
      this.userName,
      this.userEmail,
      this.address,
      this.total})
      : super(key: key);
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  GlobalKey<FormState> formstate = GlobalKey();
  bool _isLoading = false;
  TextEditingController Name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController delevary = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final isDark = Utils(context).getTheme;
    final Size size = Utils(context).getScreenSize;
    // final usertId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: LoadingManager(
          isLoading: _isLoading,
          child: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      head(),
                      const SizedBox(height: 0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: color,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            buildname(Name),
                            const SizedBox(height: 6),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'City',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: color,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            buildcity(city),
                            const SizedBox(height: 6),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'Complete shipping address',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: color,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            buildaddress(address),
                            const SizedBox(height: 6),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: color,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            buildemail(email),
                            const SizedBox(height: 6),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'Phone number',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: color,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            buildphone(phone),
                            const SizedBox(height: 6),
                            // Padding(
                            //   padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                            //   child: Text(
                            //     'Sale price',
                            //     style: TextStyle(
                            //       fontSize: 16,
                            //       color: color,
                            //       // fontWeight: FontWeight.bold,
                            //       fontFamily: 'times-new-roman',
                            //     ),
                            //   ),
                            // ),
                            // buildsaleprice(salePrice),
                            // const SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: Text(
                                'Delivery companies',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: color,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0, bottom: 5.0),
                              child: DropdownButton(
                                borderRadius: BorderRadius.circular(20),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: color,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: 'times-new-roman',
                                ),
                                value: dropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 20),

                            Center(
                              child: Row(
                                children: [
                                  FittedBox(
                                    child: TextWidget(
                                      fontFamily: 'times-new-roman',
                                      text:
                                          'Total: \$${double.parse(widget.total.toString())}',
                                      color: Colors.red,
                                      textSize: 18,
                                      isTitle: true,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  TextWidget(
                                    fontFamily: 'times-new-roman',
                                    text:
                                        'Paiement when recieving\nIt will take 10-14 days',
                                    color: color,
                                    textSize: 12,
                                    isTitle: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 00.0),
                        child: Container(
                          width: 370,
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
                                ]),
                          ),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            onPressed: () async {
                              // await uploadImages();
                              if (Name.text!.isEmpty) {
                                print("Name field is missing");
                                warningDialog(
                                    title: "Error",
                                    subTitle: "Name field is missing",
                                    context: context);
                                return;
                              }
                              if (address.text!.isEmpty) {
                                print("Address field is missing");
                                warningDialog(
                                    title: "Error",
                                    subTitle: "Address field is missing",
                                    context: context);
                                return;
                              }
                              if (email.text!.isEmpty) {
                                print("Email field is missing");
                                warningDialog(
                                    title: "Error",
                                    subTitle: "Email field is missing",
                                    context: context);
                                return;
                              }
                              if (email.text! != widget.userEmail.toString()) {
                                print("Please enter your email");
                                warningDialog(
                                    title: "Error",
                                    subTitle: "Please enter your email",
                                    context: context);
                                return;
                              }
                              if (dropdownvalue.toString()!.isEmpty) {
                                print("Delivery companies is missing");
                                warningDialog(
                                    title: "Error",
                                    subTitle:
                                        "Delivery companise field is missing",
                                    context: context);
                                return;
                              }

                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => BottomBarScreen(
                              //       id: widget.userId.toString(),
                              //       name: widget.userName,
                              //       email: widget.userEmail.toString(),
                              //       // currentIndex: 0,
                              //     ),
                              //   ),
                              // );
                              showDialog(
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
                                        Text('Order now'),
                                      ],
                                    ),
                                    content: Text('Are you sure?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          if (Navigator.canPop(context)) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: TextWidget(
                                          fontFamily: 'times-new-roman',
                                          color: Colors.cyan,
                                          text: 'Cancel',
                                          textSize: 18,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          // fct();
                                          // Navigator.canPop(context) ? Navigator.of(context).pop() : null;

                                          await DeleteAllProductsFromCart(
                                              widget.userId.toString());
                                          setState(() {});
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomBarScreen(
                                                id: widget.userId.toString(),
                                                name: widget.userName,
                                                email:
                                                    widget.userEmail.toString(),
                                                address:
                                                    widget.address.toString(),
                                                // currentIndex: 0,
                                              ),
                                            ),
                                          );
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
                            },
                            child: Row(
                              children: const [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 110),
                                    child: Text(
                                      'Order now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'times-new-roman',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget head() => Padding(
        padding: const EdgeInsets.only(
          bottom: 0.0,
          left: 20.0,
          right: 20.0,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 10,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                  bottomLeft: Radius.circular(60),
                ),
              ),
            ),
            const Text(
              'SuppMe',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 62, 90, 116),
                fontFamily: 'Pacifico-Regular',
                fontSize: 35,
              ),
            ),
          ],
        ),
      );
  Widget buildcity(var city) => TextFormField(
        keyboardType: TextInputType.name,
        controller: city,
        style: const TextStyle(color: Color.fromARGB(255, 90, 96, 105)),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: Color.fromARGB(255, 226, 204, 204),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: GradientOutlineInputBorder(
            width: 3.0,
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 80, 160, 180),
                  Color.fromARGB(255, 51, 66, 73)
                ]),
          ),
          // prefixIcon:
          //     const Icon(Icons.person, color: Color.fromARGB(255, 90, 96, 105)),
          // filled: true,
          // fillColor: const Color.fromRGBO(30, 30, 30, .51),
        ),
      );
  Widget buildname(var name) => TextFormField(
        keyboardType: TextInputType.name,
        controller: name,
        style: const TextStyle(color: Color.fromARGB(255, 90, 96, 105)),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: Color.fromARGB(255, 226, 204, 204),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: GradientOutlineInputBorder(
            width: 3.0,
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 80, 160, 180),
                  Color.fromARGB(255, 51, 66, 73)
                ]),
          ),
          // prefixIcon:
          //     const Icon(Icons.person, color: Color.fromARGB(255, 90, 96, 105)),
          // filled: true,
          // fillColor: const Color.fromRGBO(30, 30, 30, .51),
        ),
      );
  Widget buildphone(var phone) => TextFormField(
        keyboardType: TextInputType.number,
        controller: phone,
        style: const TextStyle(color: Color.fromARGB(255, 90, 96, 105)),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: Color.fromARGB(255, 226, 204, 204),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: GradientOutlineInputBorder(
            width: 3.0,
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 80, 160, 180),
                  Color.fromARGB(255, 51, 66, 73)
                ]),
          ),
          // prefixIcon:
          //     const Icon(Icons.person, color: Color.fromARGB(255, 90, 96, 105)),
          // filled: true,
          // fillColor: const Color.fromRGBO(30, 30, 30, .51),
        ),
      );

  Widget buildemail(var email) => TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: email,
        style: const TextStyle(color: Color.fromARGB(255, 90, 96, 105)),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: Color.fromARGB(255, 226, 204, 204),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: GradientOutlineInputBorder(
            width: 3.0,
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 80, 160, 180),
                  Color.fromARGB(255, 51, 66, 73)
                ]),
          ),
          // prefixIcon:
          //     const Icon(Icons.person, color: Color.fromARGB(255, 90, 96, 105)),
          // filled: true,
          // fillColor: const Color.fromRGBO(30, 30, 30, .51),
        ),
      );

  Widget buildaddress(var address) => TextFormField(
        keyboardType: TextInputType.text,
        maxLines: 2,
        controller: address,
        style: const TextStyle(color: Color.fromARGB(255, 90, 96, 105)),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: Color.fromARGB(255, 226, 204, 204),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: GradientOutlineInputBorder(
            width: 3.0,
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 80, 160, 180),
                  Color.fromARGB(255, 51, 66, 73)
                ]),
          ),
          // prefixIcon:
          //     const Icon(Icons.person, color: Color.fromARGB(255, 90, 96, 105)),
          // filled: true,
          // fillColor: const Color.fromRGBO(30, 30, 30, .51),
        ),
      );

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
}
