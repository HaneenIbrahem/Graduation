import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/comments.dart';
import 'package:new_design/services/utils.dart';
import 'package:new_design/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/firebase_consts.dart';
import '../widgets/heart_btn.dart';
import 'cart.dart';

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

Future<dynamic> getwishlistproduct(String userId) async {
  Response response = await post(
      Uri.parse(
          "https://doniaserver1.000webhostapp.com/view_user_wishlist.php"),
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

Future<dynamic> addcommint(
    String productId, String userId, String commint) async {
  Response response = await post(
      Uri.parse(
          "https://doniaserver1.000webhostapp.com/add_product_commint.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'product_id': productId,
        'user_id': userId,
        'commint': commint,
      }));
  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    print("Success: " + jsonResponse['message'].toString());
  }

  return jsonResponse;
}

Future<dynamic> getallproduct() async {
  Response response = await post(
      Uri.parse("https://doniaserver1.000webhostapp.com/all_products.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}));

  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    // Navigator.of(context).pop();
    print("Success: ");
  }
  return jsonResponse;
}

class product {
  final int id;
  final String product_name;
  final String description;
  final String image_url;
  final String product_category_name;
  final int price;
  final int sale_price;

  const product({
    required this.id,
    required this.product_name,
    required this.description,
    required this.image_url,
    required this.product_category_name,
    required this.price,
    required this.sale_price,
  });

  factory product.fromJson(Map<String, dynamic> json) {
    return product(
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

class ProductDetails extends StatefulWidget {
  final String? currentuserId;
  final String? currentproductId;
  static const String routeName = "/ProductDetails";
  const ProductDetails({Key? key, this.currentuserId, this.currentproductId})
      : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late String userName, productId, userId;
/******************************* */
  // var serverToken =
  //     'AAAAugF8ZtE:APA91bG93ZCxroumqRUEE_QP5VTRt4LjXX0vOmsZMN8qMcJS5Fmk5y9s92gIJ_j4fc7cEkF8_x7vJ8XYCn39BN-EogdKmOLhZIYNoUPI-5WqDOxoULY5ckVeeIxBdLqxAsv3RXIPrg9a';
  // sendNotify(String title, String body) async {
  //   await http.post(Uri.parse('https://api.rnfirebase.io/messaging/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Authorization': 'key=$serverToken',
  //       },
  //       body: jsonEncode(
  //         <String, dynamic>{
  //           'notification': <String, dynamic>{
  //             'body': body.toString(),
  //             'title': title.toString()
  //           },
  //           'priority': 'high',
  //           'data': <String, dynamic>{
  //             'clic-action': 'FLUTTER_NOTIFICATION_CLICK',
  //             // 'id': id.toString(),
  //           },
  //           'to':
  //               'ccrk2yH6QuyEdcuqW-xPF8:APA91bFUMgPvBMObiL8w9XQk4iwuLN34D_PXMnAY0jz1TpeiUR55X0Qr7-JY9ecxpK318FEeJGDcS7qZ76mCnxz8KOP26DzdNJcHEJWPXZj1A8PElMPYbfG-ALVEf_F4Sk9HNcSmTsFU',
  //           // 'to': await FirebaseMessaging.instance.getToken()
  //         },
  //       ));
  // }
  final String serverKey =
      'AAAAugF8ZtE:APA91bG93ZCxroumqRUEE_QP5VTRt4LjXX0vOmsZMN8qMcJS5Fmk5y9s92gIJ_j4fc7cEkF8_x7vJ8XYCn39BN-EogdKmOLhZIYNoUPI-5WqDOxoULY5ckVeeIxBdLqxAsv3RXIPrg9a';
// final String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

  Future<void> sendNotification(String title, String body, String token) async {
    final http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'to': token,
        },
      ),
    );

    if (response.statusCode != 200) {
      print("Failed to send notification: ${response.statusCode}");
    }
  }

  getMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      // print("}}}}}}}}}}}}}}}}}}}}}}}}");
      // print(message.notification!.title);
      // print(message.notification!.body);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("SuppMe"),
          content: const Text("New comement to your product"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                color: Colors.green,
                padding: const EdgeInsets.all(14),
                child: const Text("okay"),
              ),
            ),
          ],
        ),
      );
    });
  }

  final TextEditingController _quantityTextController =
      TextEditingController(text: "1");
  TextEditingController commint = TextEditingController();
  late Future<dynamic> futureproducts;
  late String? idwishlist;
  late String? idcart;
  late Future<dynamic> futurewishlist;
  late Future<dynamic> futurecart;
  @override
  void initState() {
    getMessage();
    super.initState();
    futureproducts = getallproduct();
    _loadIsInWishlist();
    _loadIsInCart();
    futurewishlist = getwishlistproduct(widget.currentuserId.toString());
    futurecart = getcartproduct(widget.currentuserId.toString());
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  Future<dynamic> AddProductToWishlist(
    String userId,
    String productId,
  ) async {
    Response response = await post(
        Uri.parse("https://doniaserver1.000webhostapp.com/add_to_wishlist.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'product_id': productId, 'user_id': userId}));
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());
    if (jsonResponse['status'] == "success") {
      print("Success: " + jsonResponse['message'].toString());
      this.idwishlist = jsonResponse['message']['id'].toString();
    }

    return jsonResponse;
  }

  Future<dynamic> DeleteProductFromWishlist(
    String userId,
    String productId,
  ) async {
    Response response = await post(
        Uri.parse(
            "https://doniaserver1.000webhostapp.com/delete_from_wishlist.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'product_id': productId, 'user_id': userId}));
    var jsonResponse = jsonDecode(response.body);
    print('hhhhhhhhhhhhhhhhhhhhaaaaaaaaaaa');
    print(jsonResponse.toString());
    if (jsonResponse['status'] == "success") {
      print("Success: " + jsonResponse['message'].toString());
    }

    return jsonResponse;
  }

  Future<dynamic> AddProductToCart(
    String productId,
    String userId,
    String quantity,
  ) async {
    Response response = await post(
        Uri.parse("https://doniaserver1.000webhostapp.com/add_to_card.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'product_id': productId,
          'user_id': userId,
          'quantity': quantity
        }));
    var jsonResponse = jsonDecode(response.body);
    print('999999999999999999999999999999999999999');
    print(jsonResponse.toString());
    if (jsonResponse['status'] == "success") {
      print("Success: " + jsonResponse['message'].toString());
      this.idcart = jsonResponse['message']['id'].toString();
    }

    return jsonResponse;
  }

  Future<dynamic> DeleteProductFromCart(
    String userId,
    String productId,
  ) async {
    Response response = await post(
        Uri.parse(
            "https://doniaserver1.000webhostapp.com/delete_from_card.php"),
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

  bool _isInWishlist = false;
  void _toggleheart() {
    setState(() {
      _isInWishlist = !_isInWishlist;
    });
  }

  bool _isInCart = false;
  void _togglecart() {
    setState(() {
      _isInCart = !_isInCart;
    });
  }

  Future<void> _loadIsInWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isInWishlist = prefs.getBool('isInWishlist') ?? false;
    });
  }

  Future<void> _saveIsInWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isInWishlist', _isInWishlist);
  }

  Future<void> _loadIsInCart() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isInCart = prefs.getBool('isInCart') ?? false;
    });
  }

  Future<void> _saveIsInCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isInCart', _isInCart);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    int idd, sizee, sizeee, sizeeee;
    String? uname;
    // int commentCount = ;

    return Scaffold(
        appBar: AppBar(
          // leading: BackWidget(
          //   fct: () {
          //     // viewedProdProvider.addProductToHistory(productId: productId);
          //   },
          // ),
          leading: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // print("***************************");
              // print(widget.currentproductId.toString());
              Navigator.pop(context);
            },
            child: Icon(
              IconlyLight.arrowLeft2,
              color: color,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<dynamic>(
            future: Future.wait([futurewishlist, futureproducts, futurecart]),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              // List<Widget> wishlistproducts;
              if (snapshot.hasData) {
                sizeee = (snapshot.data[0]!['message']['size']);
                if (sizeee != 0) {
                  for (int i = 1; i <= sizeee; i++) {
                    if (widget.currentproductId.toString() ==
                        snapshot.data[0]!['message']['products']
                                [(snapshot.data[0]!['message']['size']) - i]
                            ['id']) {
                      _isInWishlist = true;
                    } else {
                      _isInWishlist = false;
                    }
                  }
                } else {
                  _isInWishlist = false;
                }
                sizeeee = (snapshot.data[2]!['message']['size']);
                if (sizeeee != 0) {
                  for (int i = 1; i <= sizeeee; i++) {
                    if (widget.currentproductId.toString() ==
                        snapshot.data[2]!['message']['products']
                                [(snapshot.data[2]!['message']['size']) - i]
                            ['id']) {
                      _isInCart = true;
                    } else {
                      _isInCart = false;
                    }
                  }
                } else {
                  _isInCart = false;
                }

                List<Widget> products;

                sizee = (snapshot.data[1]!['message']['size']);
                // for (int i = 0; i < sizee; i++) {
                //   if ((snapshot.data!['message']['products'][i]['id']) ==
                //       widget.currentuserId) {
                //     uname =
                //         snapshot.data!['message']['products'][i]['user_name'];
                //     print("!!!!!!!!!!!!!!!!!!!!!***************************");
                //     print(uname);
                //   }
                // }
                for (int i = 0; i < sizee; i++) {
                  if ((snapshot.data[1]!['message']['products'][i]['id']) ==
                      widget.currentproductId) {
                    userName = snapshot.data[1]!['message']['products'][i]
                        ['user_name'];
                    productId = widget.currentproductId.toString();
                    userId:
                    widget.currentuserId.toString();
                  }
                }

                print("!!!!!!!!!!!!!!!!!!!!!***************************");
                print(widget.currentuserId);
                products = <Widget>[
                  for (int i = 0; i < sizee; i++)
                    if ((snapshot.data[1]!['message']['products'][i]['id']) ==
                        widget.currentproductId)
                      Column(
                        children: [
                          Flexible(
                            flex: 2,
                            child: FancyShimmerImage(
                              imageUrl: snapshot.data[1]!['message']['products']
                                  [i]['image_url'],
                              boxFit: BoxFit.scaleDown,
                              width: size.width,
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20.0,
                                      left: 30.0,
                                      right: 30.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          text: snapshot.data[1]!['message']
                                              ['products'][i]['product_name'],
                                          color: color,
                                          textSize: 20.0,
                                          isTitle: true,
                                          fontFamily: 'times-new-roman',
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),

                                        // HeartBTN(
                                        //   productId: snapshot.data!['message']
                                        //       ['products'][i]['user_id'],
                                        //   // isInWishList: isInWishList,
                                        // ),
                                        IconButton(
                                          onPressed: () async {
                                            print(
                                                '55555555555555555555555555555555555');
                                            print(sizee);
                                            if (_isInWishlist == true) {
                                              DeleteProductFromWishlist(
                                                  widget.currentuserId
                                                      .toString(),
                                                  snapshot.data[1]!['message']
                                                      ['products'][i]['id']);
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                    currentuserId: widget
                                                        .currentuserId
                                                        .toString(),
                                                    currentproductId: snapshot
                                                            .data[1]!['message']
                                                        ['products'][i]['id'],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              await AddProductToWishlist(
                                                  widget.currentuserId
                                                      .toString(),
                                                  snapshot.data![1]['message']
                                                      ['products'][i]['id']);
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                    currentuserId: widget
                                                        .currentuserId
                                                        .toString(),
                                                    currentproductId: snapshot
                                                            .data[1]!['message']
                                                        ['products'][i]['id'],
                                                  ),
                                                ),
                                              );
                                            }
                                            // _isInWishlist
                                            //     ? await DeleteProductFromWishlist(
                                            //         widget.currentuserId
                                            //             .toString(),
                                            //         snapshot.data[1]!['message']
                                            //             ['products'][i]['id'])
                                            //     : await AddProductToWishlist(
                                            //         widget.currentuserId
                                            //             .toString(),
                                            //         snapshot.data![1]['message']
                                            //             ['products'][i]['id']);

                                            _toggleheart();
                                            _saveIsInWishlist();
                                          },
                                          icon: Icon(
                                            _isInWishlist
                                                ? IconlyBold.heart
                                                : IconlyLight.heart,
                                            size: 26,
                                            color: _isInWishlist
                                                ? Colors.red
                                                : color,
                                          ),
                                        ),
                                        // GestureDetector(
                                        //   onTap: () async {
                                        //     _isInWishlist
                                        //         ? await DeleteProductFromWishlist(
                                        //             widget.currentuserId.toString(),
                                        //             snapshot.data!['message']
                                        //                 ['products'][i]['id'])
                                        //         : await AddProductToWishlist(
                                        //             widget.currentuserId.toString(),
                                        //             snapshot.data!['message']
                                        //                 ['products'][i]['id']);

                                        //     _toggleheart();
                                        //     _saveIsInWishlist();
                                        //   },
                                        //   child: Icon(
                                        //     _isInWishlist
                                        //         ? IconlyBold.heart
                                        //         : IconlyLight.heart,
                                        //     size: 22,
                                        //     color:
                                        //         _isInWishlist ? Colors.red : color,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      // top: 20.0,
                                      left: 30.0,
                                      right: 30.0,
                                    ),
                                    child: TextWidget(
                                      text:
                                          "By ${snapshot.data[1]!['message']['products'][i]['user_name']}",
                                      color: color,
                                      textSize: 13.0,
                                      // isTitle: true,
                                      fontFamily: 'times-new-roman',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20.0,
                                      left: 30.0,
                                      right: 30.0,
                                    ),
                                    child: TextWidget(
                                      text: snapshot.data[1]!['message']
                                          ['products'][i]['description'],
                                      color: color,
                                      textSize: 18.0,
                                      // isTitle: true,
                                      fontFamily: 'times-new-roman',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20.0,
                                      left: 30.0,
                                      right: 30.0,
                                    ),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          text:
                                              "\$${snapshot.data[1]!['message']['products'][i]['price']}",
                                          color: Colors.green,
                                          textSize: 22,
                                          isTitle: true,
                                          fontFamily: 'times-new-roman',
                                        ),
                                        TextWidget(
                                          text: "/Piece",
                                          color: color,
                                          textSize: 12,
                                          fontFamily: 'times-new-roman',
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        // Visibility(
                                        //   visible: getCurrentProduct.isOnSale ? true : false,
                                        //   child: Text(
                                        //     '\$${getCurrentProduct.price.toStringAsFixed(2)}',
                                        //     style: TextStyle(
                                        //       fontSize: 15,
                                        //       color: color,
                                        //       decoration: TextDecoration.lineThrough,
                                        //     ),
                                        //   ),
                                        // ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4.0,
                                            horizontal: 8.0,
                                          ),
                                          // decoration: BoxDecoration(
                                          //   color: Color.fromRGBO(63, 200, 101, 1),
                                          //   borderRadius: BorderRadius.circular(5),
                                          // ),
                                          // child: TextWidget(
                                          //   text: "Free delivery",
                                          //   color: Colors.white,
                                          //   textSize: 20.0,
                                          //   isTitle: true,
                                          //   fontFamily: 'times-new-roman',
                                          // ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _quantityController(
                                        fct: () {
                                          setState(
                                            () {
                                              if (_quantityTextController
                                                      .text ==
                                                  "1") {
                                                return;
                                              } else {
                                                _quantityTextController
                                                    .text = (int.parse(
                                                            _quantityTextController
                                                                .text) -
                                                        1)
                                                    .toString();
                                              }
                                            },
                                          );
                                        },
                                        color: Colors.red,
                                        icon: CupertinoIcons.minus,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: TextField(
                                          key: const ValueKey("quantity"),
                                          textAlign: TextAlign.center,
                                          controller: _quantityTextController,
                                          keyboardType: TextInputType.number,
                                          maxLines: 1,
                                          decoration: const InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                          ),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]'),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                if (value.isEmpty) {
                                                  _quantityTextController.text =
                                                      '1';
                                                } else {
                                                  return;
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      _quantityController(
                                        fct: () {
                                          setState(
                                            () {
                                              _quantityTextController
                                                  .text = (int.parse(
                                                          _quantityTextController
                                                              .text) +
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
                                  const Spacer(),
                                  // const SizedBox(
                                  //   height: 30,
                                  // ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                3.4 /
                                                4.5,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 1,
                                            cursorColor: color,
                                            cursorHeight: 25,
                                            controller: commint,
                                            style: TextStyle(
                                              color: color,
                                            ),
                                            decoration: InputDecoration(
                                              hintText:
                                                  "  Add a new comment...",
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15.5,
                                                      horizontal: 2),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 0.2,
                                                  color: color,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              focusedBorder:
                                                  GradientOutlineInputBorder(
                                                width: .30,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                gradient: const LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      // Color.fromARGB(255, 80, 160, 180),
                                                      Color.fromARGB(
                                                          255, 80, 160, 180),
                                                      Color.fromARGB(
                                                          255, 80, 160, 180)
                                                    ]),
                                              ),
                                              suffixIcon: IconButton(
                                                onPressed: () async {
                                                  if (commint.text.isEmpty) {
                                                    print("emptyyyyyyyyyyy");
                                                  } else {
                                                    print(
                                                        "@@@@@@@@@@@@@@@@@@@@@@@@@");
                                                    print(widget.currentuserId
                                                        .toString());
                                                    addcommint(
                                                        widget.currentproductId
                                                            .toString(),
                                                        widget.currentuserId
                                                            .toString(),
                                                        commint.text);

                                                    // commentCount = 2;
                                                    commint.clear();
                                                    // await sendNotify('SuppMe',
                                                    //     'New comment to your product');
                                                    await sendNotification(
                                                        'SuppMe',
                                                        'new comment',
                                                        'ccrk2yH6QuyEdcuqW-xPF8:APA91bFUMgPvBMObiL8w9XQk4iwuLN34D_PXMnAY0jz1TpeiUR55X0Qr7-JY9ecxpK318FEeJGDcS7qZ76mCnxz8KOP26DzdNJcHEJWPXZj1A8PElMPYbfG-ALVEf_F4Sk9HNcSmTsFU');
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.send,
                                                  color: color,
                                                ),
                                              ),
                                              // filled: true,
                                              // fillColor: const Color.fromRGBO(30, 30, 30, .51),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(width: 5),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Commments(
                                                      userName: snapshot.data[
                                                                  1]!['message']
                                                              ['products'][i]
                                                          ['user_name'],
                                                      productId: widget
                                                          .currentproductId,
                                                      userId:
                                                          widget.currentuserId,
                                                    )),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            // Text(
                                            //   "$commentCount",
                                            //   style: TextStyle(
                                            //     color: color,
                                            //     fontSize: 13.0,
                                            //     // fontWeight: FontWeight.w700,
                                            //     fontFamily: 'times-new-roman',
                                            //   ),
                                            // ),
                                            Text(
                                              "Comments",
                                              style: TextStyle(
                                                color: color,
                                                fontSize: 16.0,
                                                // fontWeight: FontWeight.w700,
                                                fontFamily: 'times-new-roman',
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      // TextButton(
                                      //     onPressed: () {},
                                      //     child: Text(
                                      //       "${" Comment"}${(commentCount > 1) ? 's' : ''}",
                                      //       style: TextStyle(
                                      //         color: color,
                                      //         fontSize: 6.0,
                                      //         // fontWeight: FontWeight.w700,
                                      //         fontFamily: 'times-new-roman',
                                      //       ),
                                      //     )
                                      //     // text:
                                      //     //     "${" Comment"}${(commentCount > 1) ? 's' : ''}",
                                      //     // color: color,
                                      //     // textSize: 14.0,
                                      //     // // isTitle: true,
                                      //     // fontFamily: 'times-new-roman',
                                      //     ),
                                    ],
                                  ),
                                  // const Spacer(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 30.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                text: "Total",
                                                color: Colors.red.shade300,
                                                textSize: 20.0,
                                                isTitle: true,
                                                fontFamily: 'times-new-roman',
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                children: [
                                                  TextWidget(
                                                    text:
                                                        "\$${double.parse(snapshot.data[1]!['message']['products'][i]['price']) * int.parse(_quantityTextController.text)}/",
                                                    color: color,
                                                    textSize: 20.0,
                                                    isTitle: true,
                                                    fontFamily:
                                                        'times-new-roman',
                                                  ),
                                                  TextWidget(
                                                    text:
                                                        "${_quantityTextController.text}${" Piece"}${(int.parse(_quantityTextController.text) > 1) ? 's' : ''}",
                                                    color: color,
                                                    textSize: 16.0,
                                                    isTitle: true,
                                                    fontFamily:
                                                        'times-new-roman',
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // const Spacer(),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        Flexible(
                                          child: Material(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: InkWell(
                                              onTap: () async {
                                                if (_isInCart == true) {
                                                  await DeleteProductFromCart(
                                                      widget.currentuserId
                                                          .toString(),
                                                      snapshot.data[1]![
                                                                  'message']
                                                              ['products'][i]
                                                          ['id']);
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetails(
                                                        currentuserId: widget
                                                            .currentuserId
                                                            .toString(),
                                                        currentproductId:
                                                            snapshot.data[1]![
                                                                        'message']
                                                                    ['products']
                                                                [i]['id'],
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  await AddProductToCart(
                                                      snapshot.data[1]![
                                                              'message']
                                                          ['products'][i]['id'],
                                                      widget.currentuserId
                                                          .toString(),
                                                      _quantityTextController
                                                          .text);
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetails(
                                                        currentuserId: widget
                                                            .currentuserId
                                                            .toString(),
                                                        currentproductId:
                                                            snapshot.data[1]![
                                                                        'message']
                                                                    ['products']
                                                                [i]['id'],
                                                      ),
                                                    ),
                                                  );
                                                }

                                                _togglecart();
                                                _saveIsInCart();
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: TextWidget(
                                                  fontFamily: 'times-new-roman',
                                                  text: _isInCart
                                                      ? "In cart"
                                                      : "Add to cart",
                                                  color: Colors.white,
                                                  textSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                ];
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 1,
                  padding: EdgeInsets.zero,
                  // crossAxisSpacing: 10,
                  childAspectRatio: size.width / (size.height * 0.90),
                  children: List.generate(
                    products.length < 40 ? products.length : 4,
                    (index) {
                      return products[index];
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
                );
              }
            },
          ),
        ));
  }

  static Widget _quantityController({
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
              padding: const EdgeInsets.all(10.0),
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
