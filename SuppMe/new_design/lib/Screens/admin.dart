import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/productDetails.dart';
// import 'package:store/Screens/productDetails.dart';
// import 'package:new_design/Screens/adminAllProduct.dart';
// import 'package:new_design/Screens/productDetails.dart';
// import 'package:store/screens/login.dart';

import '../services/utils.dart';
import '../widgets/text_widget.dart';
import 'adminAllProduct.dart';
import 'login.dart';
// import 'home.dart';

Future<dynamic> getallunprovalproduct() async {
  Response response = await post(
      await Uri.parse(
          "https://doniaserver1.000webhostapp.com/all_unapproved_products.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}));

  var jsonResponse = jsonDecode(response.body);
  // print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    // Navigator.of(context).pop();
    // print("Success: ");
  }
  return jsonResponse;
}

Future<dynamic> DeleteUnaprovalProduct(
  String productId,
) async {
  Response response = await post(
      Uri.parse(
          "https://doniaserver1.000webhostapp.com/delete_unapproved_product.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'product_id': productId,
      }));
  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    print("Success: " + jsonResponse['message'].toString());
  }

  return jsonResponse;
}

Future<dynamic> Approveproduct(
  String productId,
) async {
  Response response = await post(
      Uri.parse("https://doniaserver1.000webhostapp.com/approve_product.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'product_id': productId,
      }));
  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    print("Success: " + jsonResponse['message'].toString());
    // this.idwishlist = jsonResponse['message']['id'].toString();
  }

  return jsonResponse;
}

class Admin extends StatefulWidget {
  final String? userId;
  static const String routeName = "/Admin";
  const Admin({Key? key, this.userId}) : super(key: key);

  @override
  State<Admin> createState() => _Admin();
}

class _Admin extends State<Admin> {
  final FocusNode _searchTextFocusNode = FocusNode();
  late Future<dynamic> futureunprovalproducts;

  @override
  void initState() {
    futureunprovalproducts = getallunprovalproduct();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    int sizee;
    return Scaffold(
      appBar: AppBar(
        // leading: InkWell(
        //   borderRadius: BorderRadius.circular(12),
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Icon(
        //     IconlyLight.arrowLeft2,
        //     color: color,
        //   ),
        // ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          fontFamily: 'times-new-roman',
          text: 'All Products',
          color: Colors.black,
          textSize: 20.0,
          isTitle: true,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
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
                          // _logOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Login();
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
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  fontFamily: 'times-new-roman',
                  text: 'Our products',
                  color: Colors.orange,
                  textSize: 22,
                  isTitle: true,
                ),
                // const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AdminAllProduct()));
                  },
                  child: TextWidget(
                    fontFamily: 'times-new-roman',
                    text: 'All Products in the app',
                    maxLines: 1,
                    color: Color.fromARGB(255, 80, 160, 180),
                    textSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            /////////////////////////////////////////////////////////////////////////
            FutureBuilder<dynamic>(
              future: futureunprovalproducts = getallunprovalproduct(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<Widget> unprovalproducts;
                // List<Widget> searchproducts;
                if (snapshot.hasData) {
                  sizee = (snapshot.data!['message']['size']);
                  print('/**************************************/');
                  print(sizee);
                  print('2222222222111112222222222111111111111222');
                  print(widget.userId);
                  unprovalproducts = <Widget>[
                    for (int i = 1; i <= sizee; i++)
                      if (sizee == 0)
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                        currentuserId: widget.userId.toString(),
                                        currentproductId: snapshot
                                                .data!['message']['products'][
                                            (snapshot.data!['message']
                                                    ['size']) -
                                                i]['id'],
                                      ),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FancyShimmerImage(
                                        imageUrl: snapshot.data!['message']
                                            ['products'][(snapshot
                                                .data!['message']['size']) -
                                            i]['image_url'],
                                        height: size.width * 0.4,
                                        width: size.width * 0.4,
                                        boxFit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                              flex: 3,
                                              child: TextWidget(
                                                fontFamily: 'times-new-roman',
                                                text: snapshot.data!['message']
                                                        ['products'][
                                                    (snapshot.data!['message']
                                                            ['size']) -
                                                        i]['product_name'],
                                                color: Colors.black,
                                                textSize: 18,
                                                isTitle: true,
                                                maxLines: 1,
                                              )),
                                          TextWidget(
                                            fontFamily: 'times-new-roman',
                                            text: r'$'
                                                '${snapshot.data!['message']['products'][(snapshot.data!['message']['size']) - i]['price']}',
                                            color: Colors.black,
                                            textSize: 16,
                                            isTitle: false,
                                          ),
                                          // const Icon(
                                          //   Icons.favorite_border,
                                          //   // color: Colors.red,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              // child:
                              // InkWell(
                              //   onTap: () {

                              //     Navigator.of(context).push(
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             ProductUserDetails(
                              //           userId: widget.userId.toString(),
                              //           productId: snapshot.data!['message']
                              //               ['products'][(snapshot
                              //                   .data!['message']['size']) -
                              //               i]['id'],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              //   borderRadius: BorderRadius.circular(12),
                              // child:
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FancyShimmerImage(
                                      imageUrl: snapshot.data!['message']
                                              ['products'][
                                          (snapshot.data!['message']['size']) -
                                              i]['image_url'],
                                      height: size.width * 0.4,
                                      width: size.width * 0.4,
                                      boxFit: BoxFit.fill,
                                    ),
                                  ),

                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  // for (int i = 1; i <= sizee; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            flex: 3,
                                            child: TextWidget(
                                              fontFamily: 'times-new-roman',
                                              text: snapshot.data!['message']
                                                      ['products'][
                                                  (snapshot.data!['message']
                                                          ['size']) -
                                                      i]['product_name'],
                                              color: Colors.black,
                                              textSize: 16,
                                              // isTitle: true,
                                              maxLines: 1,
                                            )),
                                        // const SizedBox(
                                        //   width: 0,
                                        //   height: 5,
                                        // ),
                                        TextWidget(
                                          fontFamily: 'times-new-roman',
                                          text: r'$'
                                              '${snapshot.data!['message']['products'][(snapshot.data!['message']['size']) - i]['price']}',
                                          color: Colors.black,
                                          textSize: 14,
                                          isTitle: false,
                                        ),
                                        // const Icon(
                                        //   Icons.favorite_border,
                                        //   // color: Colors.red,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Flexible(
                                        //     flex: 3,
                                        //     child: TextWidget(
                                        //       fontFamily: 'times-new-roman',
                                        //       text: snapshot.data!['message']
                                        //               ['products'][
                                        //           (snapshot.data!['message']
                                        //                   ['size']) -
                                        //               i]['product_name'],
                                        //       color: color,
                                        //       textSize: 18,
                                        //       isTitle: true,
                                        //       maxLines: 1,
                                        //     )),
                                        // IconButton(
                                        //   onPressed: () {
                                        //     // Navigator.of(context).push(
                                        //     //   MaterialPageRoute(
                                        //     //     builder: (context) =>
                                        //     //         ProductDetails(
                                        //     //       currentuserId: widget.userId
                                        //     //           .toString(),
                                        //     //       currentproductId: snapshot
                                        //     //               .data!['message']
                                        //     //           ['products'][(snapshot
                                        //     //                       .data![
                                        //     //                   'message']
                                        //     //               ['size']) -
                                        //     //           i]['id'],
                                        //     //     ),
                                        //     //   ),
                                        //     // );
                                        //   },
                                        //   icon: Icon(
                                        //     IconlyBroken.show,
                                        //     color: color,
                                        //     // size: 10,
                                        //   ),
                                        // ),
                                        IconButton(
                                          onPressed: () async {
                                            await Approveproduct(
                                                snapshot.data!['message']
                                                        ['products'][
                                                    (snapshot.data!['message']
                                                            ['size']) -
                                                        i]['id']);
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Admin()));
                                          },
                                          icon: Icon(
                                            IconlyBroken.editSquare,
                                            color: Colors.black,
                                            // size: 10,
                                          ),
                                        ),
                                        // IconButton(
                                        //   onPressed: () {
                                        //     Navigator.of(context).push(
                                        //       MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             ProductDetails(
                                        //           // currentuserId:
                                        //           //     widget.userId.toString(),
                                        //           currentproductId: snapshot
                                        //                       .data!['message']
                                        //                   ['products'][
                                        //               (snapshot.data!['message']
                                        //                       ['size']) -
                                        //                   i]['id'],
                                        //         ),
                                        //       ),
                                        //     );
                                        //   },
                                        //   icon: Icon(
                                        //     IconlyBroken.show,
                                        //     color: Colors.black,
                                        //     // size: 10,
                                        //   ),
                                        // ),
                                        IconButton(
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
                                                      Text("Delete product"),
                                                    ],
                                                  ),
                                                  content: Text(
                                                      "Do you want to Delete this product?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        if (Navigator.canPop(
                                                            context)) {
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      child: TextWidget(
                                                        fontFamily:
                                                            'times-new-roman',
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
                                                        DeleteUnaprovalProduct(
                                                          snapshot.data![
                                                                  'message'][
                                                              'products'][(snapshot
                                                                          .data![
                                                                      'message']
                                                                  ['size']) -
                                                              i]['id'],
                                                        );
                                                        Navigator.of(context)
                                                            .popUntil((route) =>
                                                                route.isFirst);
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Admin()));
                                                      },
                                                      child: TextWidget(
                                                        fontFamily:
                                                            'times-new-roman',
                                                        color: Colors.red,
                                                        text: 'OK',
                                                        textSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            setState(() {});
                                          },
                                          icon: Icon(
                                            IconlyBroken.delete,
                                            color: Colors.black,
                                            // size: 10,
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   width: 0,
                                        //   height: 5,
                                        // ),
                                        // TextWidget(
                                        //   fontFamily: 'times-new-roman',
                                        //   text: r'$'
                                        //       '${snapshot.data!['message']['products'][(snapshot.data!['message']['size']) - i]['price']}',
                                        //   color: color,
                                        //   textSize: 16,
                                        //   isTitle: false,
                                        // ),
                                        // const Icon(
                                        //   Icons.favorite_border,
                                        //   // color: Colors.red,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // ),
                            ),
                          ),
                        ),
                  ];

                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    // crossAxisSpacing: 6,
                    childAspectRatio: size.width / (size.height * 0.72),
                    children: List.generate(
                      unprovalproducts.length < 50
                          ? unprovalproducts.length
                          : 4,
                      // _searchTextController.text.isNotEmpty
                      //     ? searchproducts.length
                      //     : products.length,
                      (index) {
                        return unprovalproducts[index];
                      },
                    ),
                  );
                } else {
                  unprovalproducts = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.orange)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  ];
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange)),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
