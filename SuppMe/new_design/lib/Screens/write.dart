import 'dart:convert';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/productDetails.dart';
import 'package:new_design/Screens/productUserDetails.dart';
import 'package:new_design/Screens/product_register.dart';
import 'package:new_design/Screens/products.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import '../widgets/text_widget.dart';

Future<dynamic> DeleteUserProduct(
  String userId,
  String productId,
) async {
  Response response = await post(
      Uri.parse(
          "https://doniaserver1.000webhostapp.com/delete_user_product.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'product_id': productId, 'user_id': userId}));
  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    print("Success: " + jsonResponse['message'].toString());
  }

  return jsonResponse;
}

Future<dynamic> getuserproduct(String userId) async {
  Response response = await post(
      Uri.parse(
          "https://doniaserver1.000webhostapp.com/view_user_products.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'user_id': userId}));

  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    // Navigator.of(context).pop();
    print("Success: ");
  }
  return jsonResponse;
}

class userproduct {
  final int id;
  final String product_name;
  final String description;
  final String image_url;
  final String product_category_name;
  final int price;
  final int sale_price;

  const userproduct({
    required this.id,
    required this.product_name,
    required this.description,
    required this.image_url,
    required this.product_category_name,
    required this.price,
    required this.sale_price,
  });

  factory userproduct.fromJson(Map<String, dynamic> json) {
    return userproduct(
      id: json['id'],
      product_name: json['product_name'],
      description: json['description'],
      image_url: json['image_url'],
      product_category_name: json['product_category_name'],
      price: json['price'],
      sale_price: json['sale_price'],
    );
  }
}

class Write extends StatefulWidget {
  static const String routeName = "/Write";
  final String? userId;
  final String? userName;
  final String? userEmail;
  const Write({Key? key, this.userId, this.userName, this.userEmail})
      : super(key: key);
  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  late Future<dynamic> futureuserproduct;
  @override
  void initState() {
    super.initState();
    futureuserproduct = getuserproduct(widget.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    int sizee;
    final Size size = Utils(context).getScreenSize;
    final isDark = Utils(context).getTheme;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    // final usertId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
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
        elevation: 0.5,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          fontFamily: 'times-new-roman',
          text: 'Your Products',
          color: color,
          textSize: 24,
          isTitle: true,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // warningDialog(
        //       //   title: "Empty your cart?",
        //       //   subTitle: "Are you sure?",
        //       //   context: context,
        //       // );
        //     },
        //     icon: Icon(
        //       IconlyBroken.setting,
        //       color: color,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              fontFamily: 'times-new-roman',
              text: 'Have a product?'.toUpperCase(),
              color: Color.fromARGB(255, 122, 129, 139),
              textSize: 12,
              isTitle: false,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    IconlyLight.edit,
                    color: color,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, ProductRegister.routeName,
                      //     arguments: widget.userId.toString());
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductRegister(
                              userId: widget.userId.toString(),
                              userName: widget.userName.toString(),
                              userEmail: widget.userEmail.toString())));
                    },
                    child: TextWidget(
                      fontFamily: 'times-new-roman',
                      text: 'Post new product',
                      color: Colors.blue,
                      textSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SingleChildScrollView(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         const SizedBox(
            //           height: 50.0,
            //         ),
            //         Image.asset(
            //           "assets/history.png",
            //           width: double.infinity,
            //           height: size.height * 0.4,
            //         ),
            //         const SizedBox(
            //           height: 10.0,
            //         ),
            //         const Text(
            //           "whoops!",
            //           style: TextStyle(
            //             color: Colors.red,
            //             fontSize: 40.0,
            //             fontWeight: FontWeight.w700,
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 20.0,
            //         ),
            //         TextWidget(
            //           fontFamily: 'times-new-roman',
            //           text: "Your don't have any products yet",
            //           color: Colors.cyan,
            //           textSize: 20.0,
            //         ),
            //         const SizedBox(
            //           height: 20.0,
            //         ),
            //         // TextWidget(
            //         //   fontFamily: 'times-new-roman',
            //         //   text: "No products has been viewed yet!",
            //         //   color: Colors.cyan,
            //         //   textSize: 20.0,
            //         // ),
            //         SizedBox(
            //           height: size.height * 0.1,
            //         ),
            //         // ElevatedButton(
            //         //   style: ElevatedButton.styleFrom(
            //         //     elevation: 0.0,
            //         //     shape: RoundedRectangleBorder(
            //         //       borderRadius: BorderRadius.circular(8.0),
            //         //       side: BorderSide(
            //         //         color: color,
            //         //       ),
            //         //     ),
            //         //     primary: Theme.of(context).colorScheme.secondary,
            //         //   ),
            //         //   onPressed: () {
            //         //     // GlobalMethods.navigateTo(
            //         //     //   ctx: context,
            //         //     //   routeName: FeedsScreen.routeName,
            //         //     // );
            //         //   },
            //         //   child: Padding(
            //         //     padding: const EdgeInsets.symmetric(
            //         //       horizontal: 40.0,
            //         //       vertical: 20.0,
            //         //     ),
            //         //     child: TextWidget(
            //         //       fontFamily: 'times-new-roman',
            //         //       text: "Shop now",
            //         //       color: isDark
            //         //           ? Colors.grey.shade300
            //         //           : Colors.grey.shade800,
            //         //       textSize: 20.0,
            //         //       isTitle: true,
            //         //     ),
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),

            FutureBuilder(
                future: futureuserproduct,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  List<Widget> userproducts;
                  if (snapshot.hasData) {
                    sizee = (snapshot.data!['message']['size']);
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
                              "assets/history.png",
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
                              text: "Your don't have any products yet",
                              color: Colors.cyan,
                              textSize: 20.0,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            // TextWidget(
                            //   fontFamily: 'times-new-roman',
                            //   text: "Explore more and shortlist some items",
                            //   color: Colors.cyan,
                            //   textSize: 20.0,
                            // ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            // ElevatedButton(
                            //   style: ElevatedButton.styleFrom(
                            //     elevation: 0.0,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8.0),
                            //       side: BorderSide(
                            //         color: color,
                            //       ),
                            //     ),
                            //     primary:
                            //         Theme.of(context).colorScheme.secondary,
                            //   ),
                            //   onPressed: () {
                            //     // GlobalMethods.navigateTo(
                            //     //   ctx: context,
                            //     //   routeName: FeedsScreen.routeName,
                            //     // );
                            //     Navigator.pushNamed(
                            //       context,
                            //       Product.routeName,
                            //       arguments: widget.userId.toString(),
                            //     );
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //       horizontal: 40.0,
                            //       vertical: 20.0,
                            //     ),
                            //     child: TextWidget(
                            //       fontFamily: 'times-new-roman',
                            //       text: "Add a wish",
                            //       color: isDark
                            //           ? Colors.grey.shade300
                            //           : Colors.grey.shade800,
                            //       textSize: 20.0,
                            //       isTitle: true,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    } // if sizee == 0
                    else {
                      userproducts = <Widget>[
                        for (int i = 1; i <= sizee; i++)
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
                                                color: color,
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
                                            color: color,
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
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                    currentuserId: widget.userId
                                                        .toString(),
                                                    currentproductId: snapshot
                                                            .data!['message']
                                                        ['products'][(snapshot
                                                                    .data![
                                                                'message']
                                                            ['size']) -
                                                        i]['id'],
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              IconlyBroken.show,
                                              color: color,
                                              // size: 10,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductUserDetails(
                                                    userId: widget.userId
                                                        .toString(),
                                                    productId: snapshot
                                                            .data!['message']
                                                        ['products'][(snapshot
                                                                    .data![
                                                                'message']
                                                            ['size']) -
                                                        i]['id'],
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              IconlyBroken.editSquare,
                                              color: color,
                                              // size: 10,
                                            ),
                                          ),
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
                                                          DeleteUserProduct(
                                                            widget.userId
                                                                .toString(),
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
                                                                  route
                                                                      .isFirst);
                                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                              builder: (context) => Write(
                                                                  userId: widget
                                                                      .userId
                                                                      .toString(),
                                                                  userName: widget
                                                                      .userName
                                                                      .toString(),
                                                                  userEmail: widget
                                                                      .userEmail
                                                                      .toString())));
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
                                              color: color,
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
                        // crossAxisSpacing: 10,
                        childAspectRatio: size.width / (size.height * 0.72),
                        children: List.generate(
                          userproducts.length < 40 ? userproducts.length : 4,
                          (index) {
                            return userproducts[index];
                          },
                        ),
                      );
                    }
                  } else {
                    userproducts = const <Widget>[
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
                })
          ],
        ),
      ),
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

// Future<dynamic> setImage(File Imagepath) async {
//   if (Imagepath.path.isNotEmpty) {
// .
//   }
// }
