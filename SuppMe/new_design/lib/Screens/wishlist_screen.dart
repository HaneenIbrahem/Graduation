import 'dart:convert';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/productDetails.dart';
import 'package:new_design/Screens/products.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../widgets/text_widget.dart';

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

class wishlist {
  final int id;
  final String product_name;
  final String description;
  final String image_url;
  final String product_category_name;
  final int price;
  final int sale_price;

  const wishlist({
    required this.id,
    required this.product_name,
    required this.description,
    required this.image_url,
    required this.product_category_name,
    required this.price,
    required this.sale_price,
  });

  factory wishlist.fromJson(Map<String, dynamic> json) {
    return wishlist(
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

class WishListScreen extends StatefulWidget {
  final String? userId;
  static const routeName = "/WishListScreen";
  const WishListScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late Future<dynamic> futurewishlist;
  @override
  void initState() {
    super.initState();
    futurewishlist = getwishlistproduct(widget.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    int sizee;
    // final userId = ModalRoute.of(context)!.settings.arguments as String;
    bool isEmpty = true;
    final Color color = Utils(context).color;
    final Size size = Utils(context).getScreenSize;
    final isDark = Utils(context).getTheme;
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
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: TextWidget(
            fontFamily: 'times-new-roman',
            text: 'Wishlist',
            color: Colors.black,
            textSize: 20.0,
            isTitle: true,
          ),
        ),
        body: FutureBuilder<dynamic>(
          future: futurewishlist,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Widget> wishlistproducts;
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
                        "assets/wishlist.png",
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
                        text: "Your wishlist is empty",
                        color: Colors.cyan,
                        textSize: 20.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextWidget(
                        fontFamily: 'times-new-roman',
                        text: "Explore more and shortlist some items",
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
                            text: "Add a wish",
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
                wishlistproducts = <Widget>[
                  for (int i = 1; i <= sizee; i++)
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

                              Navigator.of(context).pushReplacement(
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
                            borderRadius: BorderRadius.circular(12),
                            // child:
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FancyShimmerImage(
                                    imageUrl: snapshot.data!['message']
                                        ['products'][(snapshot.data!['message']
                                            ['size']) -
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
                                                ['products'][(snapshot
                                                    .data!['message']['size']) -
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
                    wishlistproducts.length < 40 ? wishlistproducts.length : 4,
                    (index) {
                      return wishlistproducts[index];
                    },
                  ),
                );
              }
            } else {
              wishlistproducts = const <Widget>[
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
}
