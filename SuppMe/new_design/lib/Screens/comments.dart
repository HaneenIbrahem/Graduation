import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'dart:js_util';
import 'package:flutter_iconly/flutter_iconly.dart';
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

Future<dynamic> getallcomments(String productId) async {
  Response response = await post(
      Uri.parse(
          "https://doniaserver1.000webhostapp.com/view_product_commints.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'product_id': productId}));

  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    // Navigator.of(context).pop();
    print("Success: ");
  }
  return jsonResponse;
}

class Commments extends StatefulWidget {
  final String? userId;
  final String? productId;
  final String? userName;

  static const String routeName = "/Commments";
  Commments({Key? key, this.userId, this.productId, this.userName})
      : super(key: key);
  @override
  State<Commments> createState() => _CommmentsState();
}

class _CommmentsState extends State<Commments> {
  GlobalKey<FormState> formstate = GlobalKey();
  late Future<dynamic> futurecommemts;

  @override
  void initState() {
    super.initState();
    futurecommemts = getallcomments(widget.productId.toString());
  }

  File? imageFile;
  var imagepicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    List<Color> gridColors = [
      const Color(0xff53B175),
      const Color(0xffF8A44C),
      const Color(0xffF7A593),
      const Color(0xffD3B0E0),
      const Color(0xffFDE598),
      const Color(0xffB7DFF5),
      const Color(0xff53B175),
      const Color(0xffF8A44C),
      const Color(0xffF7A593),
      const Color(0xffD3B0E0),
      const Color(0xffFDE598),
      const Color(0xffB7DFF5),
      const Color(0xff53B175),
      const Color(0xffF8A44C),
      const Color(0xffF7A593),
      const Color(0xffD3B0E0),
      const Color(0xffFDE598),
      const Color(0xffB7DFF5),
      const Color(0xff53B175),
      const Color(0xffF8A44C),
      const Color(0xffF7A593),
      const Color(0xffD3B0E0),
      const Color(0xffFDE598),
      const Color(0xffB7DFF5),
    ];
    // var dropdownvalue;
    int sizee;
    final Color color = Utils(context).color;
    final isDark = Utils(context).getTheme;
    final Size size = Utils(context).getScreenSize;
    // final usertId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          fontFamily: 'times-new-roman',
          text: 'Comments',
          color: color,
          isTitle: true,
          textSize: 22,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       warningDialog(
        //         title: "Empty your cart?",
        //         subTitle: "Are you sure?",
        //         context: context,
        //       );
        //     },
        //     icon: Icon(
        //       IconlyBroken.delete,
        //       color: color,
        //     ),
        //   ),
        // ],
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: FutureBuilder<dynamic>(
            future: futurecommemts,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              List<Widget> comments;
              if (snapshot.hasData) {
                sizee = (snapshot.data!['message']['size']);
                // print("!!!!!!@#@#@#@###@#@!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                // print(snapshot.data!['message']['commints'][0]['user_namer']);
                if (sizee == 0) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50.0,
                        ),
                        Image.asset(
                          "assets/comment.png",
                          width: double.infinity,
                          height: size.height * 0.4,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          "whoops!",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextWidget(
                          fontFamily: 'times-new-roman',
                          text: "No comments yet",
                          color: Colors.cyan,
                          textSize: 30.0,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  );
                } else {
                  comments = <Widget>[
                    for (int i = 0; i < sizee; i++)
                      // if ((snapshot.data!['message']['commints'][i]
                      //         ['id']) ==
                      //     widget.productId)
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 2.5, horizontal: 15.0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Expanded(
                      //           child: Container(
                      //               width: double.infinity,
                      //               padding: const EdgeInsets.symmetric(
                      //                   vertical: 8, horizontal: 15),
                      //               decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(25),
                      //                   border: Border.all(
                      //                       color: Colors.grey.withOpacity(0.5))),
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     'Raghad',
                      //                     // '${widget.userName.toString()}',
                      //                     style: TextStyle(
                      //                       fontSize: 16,
                      //                       color: color,
                      //                       // fontWeight: FontWeight.bold,
                      //                       fontFamily: 'times-new-roman',
                      //                     ),
                      //                   ),
                      //                   const SizedBox(
                      //                     height: 3,
                      //                   ),
                      //                   Text(
                      //                     '${(snapshot.data!['message']['commints'][i]['commint'])}',
                      //                     style: TextStyle(
                      //                       fontSize: 14.5,
                      //                       color: color,
                      //                       // fontWeight: FontWeight.bold,
                      //                       fontFamily: 'times-new-roman',
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ))),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Row(
                            children: [
                              // ignore: prefer_const_constructors
                              CircleAvatar(
                                  radius: 27,
                                  backgroundColor:
                                      gridColors[i].withOpacity(.51)
                                  // Color.fromARGB(255, 150, 230, 152),
                                  // backgroundImage:
                                  //     // const Image(image: 'assets/avatar.png')
                                  //     NetworkImage(
                                  //   'https://www.pinterest.com/baha1015god/%D8%A7%D9%81%D8%AA%D8%A7%D8%B1-%D9%85%D8%AC%D9%87%D9%88%D9%84/',
                                  // ),
                                  ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${snapshot.data!['message']['commints'][i]['user_namer']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: color,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: 'times-new-roman',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '${(snapshot.data!['message']['commints'][i]['commint'])}',
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      color: color,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: 'times-new-roman',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                  ];
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 1,
                    padding: EdgeInsets.zero,
                    // crossAxisSpacing: 10,
                    childAspectRatio: size.width / (size.height * 0.10),
                    children: List.generate(
                      comments.length,
                      (index) {
                        return comments[index];
                      },
                    ),
                  );
                  // return ListView.builder(
                  //   itemCount: comments.length,
                  //   itemBuilder: (ctx, index) {
                  //     return comments[index];
                  //     // return ChangeNotifierProvider.value(
                  //     //   value: cartItemsList[index],
                  //     //   child: CartWidget(
                  //     //     q: cartItemsList[index].quantity,
                  //     //   ),
                  //     // );
                  //   },
                  // );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
                );
              }
            }),
      ),
    );
  }
}
