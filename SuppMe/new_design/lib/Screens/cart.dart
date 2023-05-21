import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/productDetails.dart';
import 'package:new_design/Screens/products.dart';
import 'package:new_design/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../services/utils.dart';
import '../constant/firebase_consts.dart';
import 'bottomBarScreen.dart';
import 'order.dart';

Future<dynamic> DeleteProductFromCart(
  String userId,
  String productId,
) async {
  Response response = await post(
      Uri.parse("https://doniaserver1.000webhostapp.com/delete_from_card.php"),
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

Future<dynamic> getcartproduct(String userId) async {
  Response response = await post(
      Uri.parse("https://doniaserver1.000webhostapp.com/view_user_card.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'user_id': userId}));

  var jsonResponse = jsonDecode(response.body);
  print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
  print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    // Navigator.of(context).pop();
    print("Success: ");
  }
  return jsonResponse;
}

// class cart {
//   final int id;
//   final String product_name;
//   final String description;
//   final String image_url;
//   final String product_category_name;
//   final int price;
//   final int sale_price;

//   const cart({
//     required this.id,
//     required this.product_name,
//     required this.description,
//     required this.image_url,
//     required this.product_category_name,
//     required this.price,
//     required this.sale_price,
//   });

//   factory cart.fromJson(Map<String, dynamic> json) {
//     return cart(
//       id: json['id'],
//       product_name: json['product_name'],
//       description: json['description'],
//       image_url: json['image_url'],
//       product_category_name: json['product_category_name'],
//       price: json['price'],
//       sale_price: json['sale_price'],
//     );
//   }
// }

class Cart extends StatefulWidget {
  final String? userId;
  final String? userName;
  final String? userEmail;
  final String? address;
  // final int currentIndex;

  static const routeName = "/CartScreen";
  const Cart({
    Key? key,
    this.userId,
    this.userName,
    this.userEmail,
    this.address,
    // required this.currentIndex
  }) : super(key: key);
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late Future<dynamic> futurecart;
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // DeleteAllProductsFromCart(widget.userId.toString());
    // _quantityTextController.text = widget.q.toString();
    futurecart = getcartproduct(widget.userId.toString());
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int sizee;
    double total = 0.0;
    final Color color = Utils(context).color;
    final isDark = Utils(context).getTheme;
    final Size size = Utils(context).getScreenSize;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            fontFamily: 'times-new-roman',
            text: 'Cart',
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
        ),
        body: FutureBuilder<dynamic>(
          future: futurecart,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Widget> cartproducts;
            if (snapshot.hasData) {
              sizee = (snapshot.data!['message']['size']);

              // for (int j = 1; j <= sizee; j++) {
              //   _quantityTextController.text = (snapshot.data!['message']
              //           ['products'][(snapshot.data!['message']['size']) - j]
              //       ['quantity']);
              // }
              print('sizeeeeeeeeeeeeeeeeeeee @!!!!@!@!!!!!!@@@@@@!!!!!!!@');
              print(snapshot.data);
              for (int j = 1; j <= sizee; j++) {
                total = total +
                    (double.parse(snapshot.data!['message']['products'][j - 1]
                            ['price']) *
                        int.parse(snapshot.data!['message']['products']
                                [(snapshot.data!['message']['size']) - j]
                            ['quantity']));
              }

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
                        "assets/cart.png",
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
                        text: "Your cart is empty",
                        color: Colors.cyan,
                        textSize: 20.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextWidget(
                        fontFamily: 'times-new-roman',
                        text: "Add something and make me happy :)",
                        color: Colors.cyan,
                        textSize: 20.0,
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: color,
                            ),
                          ),
                          primary: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          // GlobalMethods.navigateTo(
                          //   ctx: context,
                          //   routeName: FeedsScreen.routeName,
                          // );
                          // Navigator.pushNamed(
                          //   context,
                          //   Product.routeName,
                          //   arguments: widget.userId.toString(),
                          // );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Product(
                                      userId: widget.userId.toString(),
                                    )),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 20.0,
                          ),
                          child: TextWidget(
                            fontFamily: 'times-new-roman',
                            text: "Shop now",
                            color: isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade800,
                            textSize: 20.0,
                            isTitle: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } // if sizee == 0
              else {
                cartproducts = <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.1,
                        // color: ,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(children: [
                            Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => OrderScreen(
                                          userId: widget.userId.toString(),
                                          userName: widget.userName.toString(),
                                          userEmail:
                                              widget.userEmail.toString(),
                                          address: widget.address.toString(),
                                          total: total.toString())));
                                  // await DeleteAllProductsFromCart(
                                  //     widget.userId.toString());
                                  // setState(() {});
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) {
                                  //     return AlertDialog(
                                  //       title: Row(
                                  //         children: [
                                  //           Image.asset(
                                  //             'assets/warning-sign.png',
                                  //             height: 20,
                                  //             width: 20,
                                  //             fit: BoxFit.fill,
                                  //           ),
                                  //           const SizedBox(
                                  //             width: 8,
                                  //           ),
                                  //           Text('Order now'),
                                  //         ],
                                  //       ),
                                  //       content: Text('Are you sure?'),
                                  //       actions: [
                                  //         TextButton(
                                  //           onPressed: () {
                                  //             if (Navigator.canPop(context)) {
                                  //               Navigator.pop(context);
                                  //             }
                                  //           },
                                  //           child: TextWidget(
                                  //             fontFamily: 'times-new-roman',
                                  //             color: Colors.cyan,
                                  //             text: 'Cancel',
                                  //             textSize: 18,
                                  //           ),
                                  //         ),
                                  //         TextButton(
                                  //           onPressed: () {
                                  //             // fct();
                                  //             // Navigator.canPop(context) ? Navigator.of(context).pop() : null;
                                  //             Navigator.of(context)
                                  //                 .pushReplacement(
                                  //               MaterialPageRoute(
                                  //                 builder: (context) =>
                                  //                     BottomBarScreen(
                                  //                   id: widget.userId
                                  //                       .toString(),
                                  //                   name: widget.userName,
                                  //                   email: widget.userEmail
                                  //                       .toString(),
                                  //                   address: widget.address
                                  //                       .toString(),
                                  //                   // currentIndex: 0,
                                  //                 ),
                                  //               ),
                                  //             );
                                  //           },
                                  //           child: TextWidget(
                                  //             fontFamily: 'times-new-roman',
                                  //             color: Colors.red,
                                  //             text: 'OK',
                                  //             textSize: 18,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     );
                                  //   },
                                  // );
                                  // // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  // //                             builder: (context) => BottomAppBar(
                                  // //                                 userId: widget
                                  // //                                     .userId
                                  // //                                     .toString(),
                                  // //                                 userName: widget
                                  // //                                     .userName
                                  // //                                     .toString(),
                                  // //                                 userEmail: widget
                                  // //                                     .userEmail
                                  // //                                     .toString())));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextWidget(
                                    text: 'Order Now',
                                    textSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'times-new-roman',
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            FittedBox(
                              child: TextWidget(
                                fontFamily: 'times-new-roman',
                                text: 'Total: \$${total.toStringAsFixed(2)}',
                                color: color,
                                textSize: 18,
                                isTitle: true,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      for (int i = 1; i <= sizee; i++)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  currentuserId: widget.userId.toString(),
                                  currentproductId: snapshot.data!['message']
                                      ['products'][(snapshot.data!['message']
                                          ['size']) -
                                      i]['id'],
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Expanded(
                                // child: Card(
                                // shape: RoundedRectangleBorder(
                                //   borderRadius: BorderRadius.circular(8),
                                // ),
                                // elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .cardColor
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        // InkWell(
                                        //   onTap: () {
                                        //     // Navigator.of(context).push(
                                        //     //   MaterialPageRoute(
                                        //     //     builder: (context) => ProductDetails(),
                                        //     //     arguments:
                                        //     //   ),
                                        //     // );
                                        //     // Navigator.pushNamed(
                                        //     //   context,
                                        //     //   ProductDetails.routeName,
                                        //     //   arguments: snapshot.data!['message']
                                        //     //       ['products'][(snapshot.data!['message']
                                        //     //           ['size']) -
                                        //     //       i]['id'],
                                        //     // );

                                        //     Navigator.of(context).push(
                                        //       MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             ProductDetails(
                                        //           currentuserId:
                                        //               widget.userId.toString(),
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
                                        //   borderRadius: BorderRadius.circular(12),
                                        //   // child:
                                        //   child: Column(
                                        //     children: [
                                        //       Padding(
                                        //         padding: const EdgeInsets.all(8.0),
                                        //         child: FancyShimmerImage(
                                        //           imageUrl: snapshot
                                        //                       .data!['message']
                                        //                   ['products'][
                                        //               (snapshot.data!['message']
                                        //                       ['size']) -
                                        //                   i]['image_url'],
                                        //           height: size.width * 0.4,
                                        //           width: size.width * 0.4,
                                        //           boxFit: BoxFit.fill,
                                        //         ),
                                        //       ),
                                        //       SizedBox(
                                        //         height: size.height * 0.01,
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Container(
                                          height: size.width * 0.25,
                                          width: size.width * 0.25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: FancyShimmerImage(
                                            imageUrl: snapshot.data!['message']
                                                ['products'][(snapshot
                                                    .data!['message']['size']) -
                                                i]['image_url'],
                                            boxFit: BoxFit.fill,
                                          ),
                                        ),
                                        // for (int i = 1; i <= sizee; i++)
                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(
                                        //       horizontal: 10),
                                        // child:
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Flexible(
                                            //     flex: 3,
                                            //     child:
                                            TextWidget(
                                              fontFamily: 'times-new-roman',
                                              text: snapshot.data!['message']
                                                      ['products'][
                                                  (snapshot.data!['message']
                                                          ['size']) -
                                                      i]['product_name'],
                                              color: color,
                                              textSize: 20,
                                              isTitle: true,
                                              // maxLines: 1,
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            // ),
                                            // const SizedBox(
                                            //   width: 0,
                                            //   height: 5,
                                            // ),
                                            SizedBox(
                                              width: size.width * 0.3,
                                              child: Row(
                                                children: [
                                                  _quantityController(
                                                    fct: () {
                                                      // cartProvider
                                                      //     .reduceQuantityByOne(
                                                      //         productId: cartModel
                                                      //             .productId);
                                                      setState(
                                                        () {
                                                          if (snapshot.data![
                                                                      'message']
                                                                  [
                                                                  'products'][(snapshot
                                                                              .data![
                                                                          'message']
                                                                      [
                                                                      'size']) -
                                                                  i]['quantity'] ==
                                                              "1") {
                                                            return;
                                                          } else {
                                                            snapshot.data![
                                                                    'message']
                                                                ['products'][(snapshot
                                                                        .data!['message']
                                                                    ['size']) -
                                                                i]['quantity'] = (int.parse(
                                                                        snapshot.data!['message']['products'][(snapshot.data!['message']['size']) - i]['quantity']) -
                                                                    1)
                                                                .toString();
                                                          }
                                                        },
                                                      );
                                                    },
                                                    color: Colors.red,
                                                    icon: CupertinoIcons.minus,
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: TextField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      controller: TextEditingController(
                                                          text: snapshot.data![
                                                                  'message'][
                                                              'products'][(snapshot
                                                                          .data![
                                                                      'message']
                                                                  ['size']) -
                                                              i]['quantity']),
                                                      // _quantityTextController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      maxLines: 1,
                                                      decoration:
                                                          const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(),
                                                        ),
                                                      ),
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(
                                                          RegExp('[0-9]'),
                                                        ),
                                                      ],
                                                      onChanged: (value) {
                                                        setState(
                                                          () {
                                                            if (value.isEmpty) {
                                                              snapshot.data![
                                                                      'message']
                                                                  [
                                                                  'products'][(snapshot
                                                                              .data![
                                                                          'message']
                                                                      [
                                                                      'size']) -
                                                                  i]['quantity'] = '1';
                                                            } else {
                                                              return;
                                                            }
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  _quantityController(
                                                    fct: () {
                                                      // cartProvider
                                                      //     .increaseQuantityByOne(
                                                      //         productId: cartModel
                                                      //             .productId);
                                                      setState(
                                                        () {
                                                          snapshot.data!['message']
                                                              ['products'][(snapshot
                                                                      .data!['message']
                                                                  ['size']) -
                                                              i]['quantity'] = (int.parse(snapshot.data!['message']
                                                                              ['products']
                                                                          [(snapshot.data!['message']['size']) - i]
                                                                      ['quantity']) +
                                                                  1)
                                                              .toString();
                                                        },
                                                      );
                                                    },
                                                    color: Colors.green,
                                                    icon: CupertinoIcons.plus,
                                                  ),
                                                ],
                                              ),
                                            ),
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
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  DeleteProductFromCart(
                                                      widget.userId.toString(),
                                                      snapshot.data!['message']
                                                              ['products'][
                                                          (snapshot.data![
                                                                      'message']
                                                                  ['size']) -
                                                              i]['id']);
                                                  // DeleteProductFromCart(
                                                  //     widget.userId.toString(),
                                                  //     snapshot.data!['message']
                                                  //             ['products'][i]
                                                  //         ['id']);
                                                  setState(
                                                    () {},
                                                  );
                                                  /******************** */
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BottomBarScreen(
                                                        id: widget.userId
                                                            .toString(),
                                                        name: widget.userName,
                                                        email: widget.userEmail
                                                            .toString(),
                                                        address: widget.address
                                                            .toString(),
                                                        // currentIndex: 2,
                                                      ),
                                                    ),
                                                  );

                                                  /*************** */
                                                  //     Navigator.of(context)
                                                  //     .push(
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         BottomBarScreen(
                                                  //       id: widget.userId
                                                  //           .toString(),
                                                  //       name: widget.userName,
                                                  //       email: widget.userEmail
                                                  //           .toString(),
                                                  //       address: widget.address
                                                  //           .toString(),
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                                child: const Icon(
                                                  CupertinoIcons
                                                      .cart_badge_minus,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              // HeartBTN(
                                              //   productId: getCurrentProduct.id,
                                              //   isInWishList: isInWishList,
                                              // ),
                                              TextWidget(
                                                text:
                                                    "\$${double.parse(snapshot.data!['message']['products'][i - 1]['price']) * int.parse(snapshot.data!['message']['products'][(snapshot.data!['message']['size']) - i]['quantity'])}",
                                                color: color,
                                                textSize: 18,
                                                maxLines: 1,
                                                fontFamily: 'times-new-roman',
                                              ),
                                            ],
                                          ),
                                        ),
                                        // ),
                                        //   ],
                                        // ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  )
                ];
                return
                    // GridView.count(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   crossAxisCount: 2,
                    //   padding: EdgeInsets.zero,
                    //   // crossAxisSpacing: 10,
                    //   childAspectRatio: size.width / (size.height * 0.62),
                    //   children: List.generate(
                    //     cartproducts.length < 40 ? cartproducts.length : 4,
                    //     (index) {
                    //       return cartproducts[index];
                    //     },
                    //   ),
                    // );
                    ListView.builder(
                  itemCount: cartproducts.length,
                  itemBuilder: (ctx, index) {
                    return cartproducts[index];
                    // return ChangeNotifierProvider.value(
                    //   value: cartItemsList[index],
                    //   child: CartWidget(
                    //     q: cartItemsList[index].quantity,
                    //   ),
                    // );
                  },
                );
              }
            } else {
              cartproducts = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ];
              return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
              );
            }
          },
        ));
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

  Widget _quantityController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
