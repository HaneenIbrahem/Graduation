import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/home.dart';
import 'package:new_design/Screens/products.dart';
import 'package:new_design/Screens/success.dart';
import 'package:new_design/Screens/viewed_recently_screen.dart';
import 'package:new_design/Screens/wishlist_screen.dart';
import 'package:new_design/Screens/write.dart';

// import 'package:new_design/services/global_methods.dart';
import 'package:new_design/Screens/forgetPassword.dart';
import 'package:new_design/Screens/loading_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/firebase_consts.dart';
import '../provider/dark_theme_provider.dart';
import '../widgets/text_widget.dart';
import 'login.dart';
import 'order.dart';

Future<dynamic> updataddress(String userid, String address) async {
  Response response = await post(
      Uri.parse("https://doniaserver1.000webhostapp.com/edit_user_address.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'user_id': userid,
        'address': address,
      }));
  var jsonResponse = jsonDecode(response.body);
  print("**************************************************");
  print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    // Navigator.of(context).pop();
    print("Success: ");
  }
}

class UserScreen extends StatefulWidget {
  final String? email;
  final String? name;
  final String? id;
  final String? address;
  // final int currentIndex;
  // UserScreen({});
  const UserScreen({
    Key? key,
    this.name,
    this.email,
    this.id,
    this.address,
    // required this.currentIndex
  }) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // String? _address;
  final TextEditingController _addressTextController =
      TextEditingController(text: "");

  // final user = authInstance.currentUser;
  // Future<dynamic> userBackend(String email, String name) async {
  //   Response response = await post(
  //       Uri.parse("https://doniaserver1.000webhostapp.com/singup.php"),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode({'email': email, 'name': name}));

  //   var jsonResponse = jsonDecode(response.body);
  //   // print("welcome");
  //   print(jsonResponse.toString());
  //   if (jsonResponse['status'] == "success") {
  //     debugPrint("Success: " + jsonResponse['message'].toString());
  //     // this.id = jsonResponse['message']['id'].toString();
  //     this.name = jsonResponse['message']['name'];
  //     this.email = jsonResponse['message']['email'];
  //     // this.password = jsonResponse['message']['password'];
  //     // Navigator.of(context).pushReplacement(
  //     //   MaterialPageRoute(builder: (context) => BottomBarScreen()),
  //     // );
  //   }

  //   return jsonResponse;
  // }

  // final user = authInstance.currentUser;
  // final user = null;

  // @override
  // void initState() {
  //   super.initState();
  //   getUserData();
  // }

  bool _isLoading = false;
  // String? _email;
  // String? _name;
  // String? _address;
  // Future<void> getUserData() async {
  // setState(() => _isLoading = true);
  // if (user == null) {
  //   setState(() => _isLoading = false);
  //   return;
  // }
  // try {
  //   String uid = user!.uid;
  //   final DocumentSnapshot userDoc =
  //       await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //   // ignore: unnecessary_null_comparison
  //   if (userDoc == null) {
  //     return;
  //   } else {
  //     _email = userDoc.get('email');
  //     _name = userDoc.get('name');
  //     _address = userDoc.get('shippingAddress');
  //     _addressTextController.text = userDoc.get('shippingAddress');
  //   }
  // } catch (error) {
  //   setState(() => _isLoading = false);
  //   // GlobalMethods.errorDialog(subTitle: '$error', context: context);
  // } finally {
  //   setState(() => _isLoading = false);
  // }
  // }

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  Future<void> _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    int index;
    // final info = ModalRoute.of(context)!.settings.arguments;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        // child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Hi,  ',
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.name == null
                              ? "Name"
                              : widget.name.toString(),
                          style: TextStyle(
                            color: color,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // userBackend(_email!, _name!);
                              // print('object');
                              // print(_name);
                              print('My name is pressed');
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    fontFamily: 'times-new-roman',
                    text: widget.email == null
                        ? 'Email Address'
                        : widget.email.toString(),
                    color: color,
                    textSize: 18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTiles(
                    title: 'Products',
                    // subtitle: 'Shipping Address',
                    icon: IconlyLight.paper,
                    onPressed: () async {
                      // await Navigator.pushNamed(
                      //   context,
                      //   Write.routeName,
                      //   arguments: widget.id.toString(),
                      // );
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Write(
                              userId: widget.id.toString(),
                              userName: widget.name.toString(),
                              userEmail: widget.email.toString())));
                    },
                    color: color,
                  ),
                  _listTiles(
                    title: 'Address',
                    subtitle: 'Shipping Address',
                    icon: IconlyLight.location,
                    onPressed: () async {
                      // await _showAddressDialog();
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Update your address'),
                            content: TextField(
                              // onChanged: (value) {
                              //   print('_addressTextController.text ${_addressTextController.text}');
                              // },
                              controller: TextEditingController(
                                  text: widget.address.toString()),
                              maxLines: 3,
                              decoration: const InputDecoration(
                                  hintText: "Your shipping address"),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  print(widget.address);
                                  await updataddress(widget.id.toString(),
                                      _addressTextController.text);

                                  // try {

                                  //   // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  // setState(() =>
                                  //     _address = _addressTextController.text);
                                  // } catch (error) {
                                  //   // GlobalMethods.errorDialog(
                                  //   //     subTitle: '$error', context: context);
                                  // }
                                },
                                child: const Text('Update'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    color: color,
                  ),
                  // _listTiles(
                  //   title: 'Orders',
                  //   icon: IconlyLight.bag,
                  //   onPressed: () {
                  //     // GlobalMethods.navigateTo(
                  //     //   ctx: context,
                  //     //   routeName: OrdersScreen.routeName,
                  //     // );
                  //     // Navigator.pushNamed(context, OrdersScreen.routeName);
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) => OrdersScreen(),
                  //       ),
                  //     );
                  //   },
                  //   color: color,
                  // ),
                  _listTiles(
                    title: 'Wishlist',
                    icon: IconlyLight.heart,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              WishListScreen(userId: widget.id.toString()),
                        ),
                      );
                      //   Navigator.pushNamed(
                      //   context,
                      //   Product.routeName,
                      //   arguments: widget.id.toString(),
                      // );
                    },
                    color: color,
                  ),
                  // _listTiles(
                  //   title: 'Viewed',
                  //   icon: IconlyLight.show,
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) => ViewedRecentlyScreen(),
                  //       ),
                  //     );
                  //   },
                  //   color: color,
                  // ),
                  _listTiles(
                    title: 'Forget password',
                    icon: IconlyLight.unlock,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ForgetPassword(),
                        ),
                      );
                    },
                    color: color,
                  ),
                  SwitchListTile(
                    title: TextWidget(
                      fontFamily: 'times-new-roman',
                      text:
                          themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                      color: color,
                      textSize: 18,
                      // isTitle: true,
                    ),
                    secondary: Icon(
                      themeState.getDarkTheme
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                    onChanged: (bool value) {
                      setState(
                        () {
                          themeState.setDarkTheme = value;
                        },
                      );
                    },
                    value: themeState.getDarkTheme,
                  ),
                  _listTiles(
                    color: color,
                    title: 'Logout',
                    icon: IconlyLight.logout,
                    onPressed: () {
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
                                Text("Sign out"),
                              ],
                            ),
                            content: Text("Do you want to sign out"),
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
                                onPressed: () {
                                  // fct();
                                  // Navigator.canPop(context)
                                  //     ? Navigator.of(context).pop()
                                  //     : null;
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const Home(),
                                  //   ),
                                  // );
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                  _logOut();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Home();
                                      },
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
                      // GlobalMethods.warningDialog(
                      //   title: "Sign out",
                      //   subTitle: "Do you want to sign out",
                      //   fct: () async {
                      //     await authInstance.signOut();
                      //     // await googleSignIn.signOut();
                      //     // ignore: use_build_context_synchronously
                      //     Navigator.of(context).push(
                      //       MaterialPageRoute(
                      //         builder: (context) =>  Login(),
                      //       ),
                      //     );
                      //   },
                      //   context: context,
                      // );
                    },
                  ),
                  // listTileAsRow(),
                ],
              ),
            ),
          ),
        ),
        // ),
      ),
    );
  }

  // Future<void> _showAddressDialog() async {
  //   // await showDialog(
  //   //   context: context,
  //   //   builder: (context) {
  //   //     return AlertDialog(
  //   //       title: const Text('Update your address'),
  //   //       content: TextField(
  //   //         // onChanged: (value) {
  //   //         //   print('_addressTextController.text ${_addressTextController.text}');
  //   //         // },
  //   //         controller: _addressTextController,
  //   //         maxLines: 3,
  //   //         decoration:
  //   //             const InputDecoration(hintText: "Your shipping address"),
  //   //       ),
  //   //       actions: [
  //   //         TextButton(
  //   //           onPressed: () async {
  //   //             // if (user == null) {
  //   //             //   Navigator.pop(context);
  //   //             //   // GlobalMethods.errorDialog(
  //   //             //   //     subTitle: "No user found, Please login first",
  //   //             //   // context: context);
  //   //             //   return;
  //   //             // }
  //   //             // String uid = user!.uid;
  //   //             // try {
  //   //             //   await FirebaseFirestore.instance
  //   //             //       .collection('users')
  //   //             //       .doc(uid)
  //   //             //       .update({
  //   //             //     'shippingAddress': _addressTextController.text,
  //   //             //   });
  //   //             //   // ignore: use_build_context_synchronously
  //   //             //   Navigator.pop(context);
  //   //             //   setState(() => _address = _addressTextController.text);
  //   //             // } catch (error) {
  //   //             //   // GlobalMethods.errorDialog(
  //   //             //   //     subTitle: '$error', context: context);
  //   //             // }
  //   //           },
  //   //           child: const Text('Update'),
  //   //         ),
  //   //       ],
  //   //     );
  //   //   },
  //   // );
  // }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        fontFamily: 'times-new-roman',
        text: title,
        color: color,
        textSize: 22,
        // isTitle: true,
      ),
      subtitle: TextWidget(
        fontFamily: 'times-new-roman',
        text: subtitle ?? "",
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
