import 'dart:convert';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/productDetails.dart';
import 'package:new_design/Screens/products.dart';
import 'package:new_design/Screens/success.dart';
import 'package:new_design/Screens/write.dart';
import 'package:provider/provider.dart';

import '../constant/consts.dart';
import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import '../widgets/text_widget.dart';

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

class MainPage extends StatefulWidget {
  final String? currentUserId;
  // final int? currentIndex;
  const MainPage({
    Key? key,
    this.currentUserId,
    //  required this.currentIndex
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<dynamic> futureproducts;

  initialMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Success()));
    }
  }

  @override
  void initState() {
    initialMessage();
    super.initState();
    futureproducts = getallproduct();
  }

  // _getFromGallery() async {
  //   var y = await getallproduct();
  //   if (y['status'] == "success") {
  //     var z = y['message'];
  //     var v = z['products'];
  //     var id = (v[0]['id']);
  //     var product_name = (v[0]['product_name']);
  //     var description = (v[0]['description']);
  //     var image_url = (v[0]['image_url']);
  //     var product_category_name = (v[0]['product_category_name']);
  //     var price = (v[0]['price']);
  //     var sale_price = (v[0]['sale_price']);
  //     print("all message");
  //     print(y['message']);
  //     print("products");
  //     print(z['products']);
  //     print("id");
  //     print(id);
  //   }
  //   return v;
  // }
  bool _isLoading = false;
  bool? isInWishList;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeState = Provider.of<DarkThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    int sizee;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.33,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Consts.offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: Consts.offerImages.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Color.fromARGB(255, 190, 190, 148),
                    activeColor: Color.fromARGB(255, 245, 188, 113),
                  ),
                ),
                // control: const SwiperControl(color: Colors.black),
              ),
            ),
            // TextButton(
            //   onPressed: () async {
            //     // Navigator.of(context).pushReplacement(
            //     //     MaterialPageRoute(builder: (context) => OnSaleScreen()));
            //   },
            //   child: TextWidget(
            //     fontFamily: 'times-new-roman',
            //     text: 'View all',
            //     maxLines: 1,
            //     color: Colors.blue,
            //     textSize: 20,
            //   ),
            // ),
            // Row(
            //   children: [
            //     RotatedBox(
            //       quarterTurns: -1,
            //       child: Row(
            //         children: [
            //           TextWidget(
            //             fontFamily: 'times-new-roman',
            //             text: 'On sale'.toUpperCase(),
            //             color: Colors.red,
            //             textSize: 22,
            //             isTitle: true,
            //           ),
            //           const SizedBox(
            //             width: 5,
            //           ),
            //           const Icon(
            //             IconlyLight.discount,
            //             color: Colors.red,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: size.height * 0.01,
            ),
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
                    // print("11111111111111111111111111111111");
                    // print(widget.currentUserId.toString());
                    // Navigator.pushNamed(
                    //   context,
                    //   Product.routeName,
                    //   arguments: widget.currentUserId.toString(),
                    // );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Product(
                              userId: widget.currentUserId.toString(),
                            )));
                  },
                  child: TextWidget(
                    fontFamily: 'times-new-roman',
                    text: 'Browse all',
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
            // for (int i = 1; i <= 2; i++)
            // Container(
            //   decoration: BoxDecoration(boxShadow: [
            //     BoxShadow(
            //       blurRadius: 50,
            //       color: Colors.grey.withOpacity(.1),
            //       spreadRadius: 20,
            //       offset: Offset(10, 10),
            //     ),
            //   ]),
            //   child:
            // Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     elevation: 10,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child:
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [

            //   InkWell(
            // onTap: () {
            //   Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(
            //       builder: (context) => Write(),
            //     ),
            //   );
            // },
            // borderRadius: BorderRadius.circular(12),
            // child:
            //  Column(
            // children: [
            FutureBuilder<dynamic>(
              future: futureproducts,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<Widget> products;
                if (snapshot.hasData) {
                  print('111111111111111111111111111');
                  print(widget.currentUserId);
                  sizee = (snapshot.data!['message']['size']);
                  print(sizee);
                  products = <Widget>[
                    for (int i = 1; i <= sizee; i++)
                      Container(
                        child: Card(
                          // color: Color.fromARGB(255, 226, 248, 253),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => ProductDetails(),
                                //     arguments:
                                //   ),
                                // );
                                // Navigator.pushNamed(
                                //   context,
                                //   ProductDetails.routeName,
                                //   arguments: snapshot.data!['message']
                                //       ['products'][(snapshot.data!['message']
                                //           ['size']) -
                                //       i]['id'],
                                // );

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                      currentuserId:
                                          widget.currentUserId.toString(),
                                      currentproductId: snapshot
                                              .data!['message']['products'][
                                          (snapshot.data!['message']['size']) -
                                              i]['id'],
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
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
                                              color: color,
                                              textSize: 18,
                                              isTitle: true,
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
                      ),
                  ];
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    // crossAxisSpacing: 10,
                    childAspectRatio: size.width / (size.height * 0.62),
                    children: List.generate(
                      products.length < 4 ? products.length : 6,
                      (index) {
                        return products[(index)];
                      },
                    ),
                  );
                }
                //else if (snapshot.hasError) {
                //   // return Text('${snapshot.error}');
                //   products = <Widget>[
                //     const Icon(
                //       Icons.error_outline,
                //       color: Colors.red,
                //       size: 60,
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(top: 16),
                //       child: Text('Error: ${snapshot.error}'),
                //     ),
                //   ];
                // }
                else {
                  products = const <Widget>[
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

                // By default, show a loading spinner.
                // return const CircularProgressIndicator();

                // Center(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: products,
                //   ),
                // );
              },
            ),
            // ],
            // )
            // ),
            // ],
            // ),
            // ),
            // ),
            // ),
          ],
        ),
      ),

      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: size.height * 0.33,
      //         child: Swiper(
      //           itemBuilder: (BuildContext context, int index) {
      //             return Image.asset(
      //               Consts.offerImages[index],
      //               fit: BoxFit.fill,
      //             );
      //           },
      //           autoplay: true,
      //           itemCount: Consts.offerImages.length,
      //           pagination: const SwiperPagination(
      //             alignment: Alignment.bottomCenter,
      //             builder: DotSwiperPaginationBuilder(
      //               color: Color.fromARGB(255, 190, 190, 148),
      //               activeColor: Color.fromARGB(255, 245, 188, 113),
      //             ),
      //           ),
      //           // control: const SwiperControl(color: Colors.black),
      //         ),
      //       ),
      //       // TextButton(
      //       //   onPressed: () async {
      //       //     // Navigator.of(context).pushReplacement(
      //       //     //     MaterialPageRoute(builder: (context) => OnSaleScreen()));
      //       //   },
      //       //   child: TextWidget(
      //       //     fontFamily: 'times-new-roman',
      //       //     text: 'View all',
      //       //     maxLines: 1,
      //       //     color: Colors.blue,
      //       //     textSize: 20,
      //       //   ),
      //       // ),
      //       // Row(
      //       //   children: [
      //       //     RotatedBox(
      //       //       quarterTurns: -1,
      //       //       child: Row(
      //       //         children: [
      //       //           TextWidget(
      //       //             fontFamily: 'times-new-roman',
      //       //             text: 'On sale'.toUpperCase(),
      //       //             color: Colors.red,
      //       //             textSize: 22,
      //       //             isTitle: true,
      //       //           ),
      //       //           const SizedBox(
      //       //             width: 5,
      //       //           ),
      //       //           const Icon(
      //       //             IconlyLight.discount,
      //       //             color: Colors.red,
      //       //           ),
      //       //         ],
      //       //       ),
      //       //     ),
      //       //   ],
      //       // ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             TextWidget(
      //               fontFamily: 'times-new-roman',
      //               text: 'Our products',
      //               color: Colors.orange,
      //               textSize: 22,
      //               isTitle: true,
      //             ),
      //             // const Spacer(),
      //             TextButton(
      //               onPressed: () {},
      //               child: TextWidget(
      //                 fontFamily: 'times-new-roman',
      //                 text: 'Browse all',
      //                 maxLines: 1,
      //                 color: Colors.blue,
      //                 textSize: 20,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),

      //       GridView.count(
      //         shrinkWrap: true,
      //         physics: const NeverScrollableScrollPhysics(),
      //         crossAxisCount: 2,
      //         padding: EdgeInsets.zero,
      //         crossAxisSpacing: 10,
      //         childAspectRatio: size.width / (size.height * 0.62),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
// Future<void> removeOneItem({
//   required String wishlistId,
//   required String productId,
// }) async {
//   final User? user = authInstance.currentUser;

//   await userCollection.doc(user!.uid).update({
//     'userWish': FieldValue.arrayRemove([
//       {
//         'wishlistId': wishlistId,
//         'productId': productId,
//       }
//     ])
//   });
//   _wishListItems.remove(productId);
//   await fetchWishlist();
//   notifyListeners();
// }

//! Delete from the firebase
// Future<void> clearOnlineWishlist() async {
//   final User? user = authInstance.currentUser;
//   await userCollection.doc(user!.uid).update({
//     'userWish': [],
//   });
// }

//! Delete from the ui only
// void clearLocalWishlist() {
//   _wishListItems.clear();
//   notifyListeners();
// }
