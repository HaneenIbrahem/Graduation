import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/productDetails.dart';

import '../services/utils.dart';
import '../widgets/text_widget.dart';

// Future<dynamic> getallproduct() async {
//   Response response = await post(
//       Uri.parse("https://doniaserver1.000webhostapp.com/all_products.php"),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode({}));

//   var jsonResponse = jsonDecode(response.body);
//   print(jsonResponse.toString());
//   if (jsonResponse['status'] == "success") {
//     // Navigator.of(context).pop();
//     print("Success: ");
//   }
//   return jsonResponse;
// }

Future<dynamic> getsearchproduct(String text_to_search) async {
  Response response = await post(
      Uri.parse("https://doniaserver1.000webhostapp.com/search_products.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'text_to_search': text_to_search}));

  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse.toString());
  print('===============================================');
  print(jsonResponse['message']['size']);
  if (jsonResponse['status'] == "success") {
    // Navigator.of(context).pop();
    print("Success: ");
  }
  return jsonResponse;
}

// class product {
//   final int id;
//   final String product_name;
//   final String description;
//   final String image_url;
//   final String product_category_name;
//   final int price;
//   final int sale_price;

//   const product({
//     required this.id,
//     required this.product_name,
//     required this.description,
//     required this.image_url,
//     required this.product_category_name,
//     required this.price,
//     required this.sale_price,
//   });

//   factory product.fromJson(Map<String, dynamic> json) {
//     return product(
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

class Product extends StatefulWidget {
  final String? userId;
  static const String routeName = "/Product";
  const Product({Key? key, this.userId}) : super(key: key);

  @override
  State<Product> createState() => _Product();
}

class _Product extends State<Product> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  // late Future<dynamic> futureproducts;
  late Future<dynamic> futuresearchproducts;

  @override
  void initState() {
    super.initState();
    // futureproducts = getallproduct();
    futuresearchproducts = getsearchproduct(_searchTextController.text);
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final userId = ModalRoute.of(context)!.settings.arguments as String;
    // print(userId);
    // print("22225555555555588888");
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    int sizee;
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
          text: 'All Products',
          color: Colors.black,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  focusNode: _searchTextFocusNode,
                  controller: _searchTextController,
                  onChanged: (value) {
                    setState(
                      () {},
                    );
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 172, 217, 228),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 80, 160, 180),
                        width: 1,
                      ),
                    ),
                    hintText: "Search...",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: Visibility(
                      visible: _searchTextFocusNode.hasFocus ? true : false,
                      child: IconButton(
                        onPressed: () {
                          _searchTextController.clear();
                          _searchTextFocusNode.unfocus();
                        },
                        icon: Icon(
                          Icons.close,
                          color: _searchTextFocusNode.hasFocus
                              ? Colors.red
                              : color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder<dynamic>(
              future: futuresearchproducts =
                  getsearchproduct(_searchTextController.text),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<Widget> searchproducts;
                // List<Widget> searchproducts;
                if (snapshot.hasData) {
                  sizee = (snapshot.data!['message']['size']);
                  print('/**************************************/');
                  print(sizee);
                  print('2222222222111112222222222111111111111222');
                  print(widget.userId);
                  searchproducts = <Widget>[
                    for (int i = 1; i <= sizee; i++)
                      _searchTextController.text.isEmpty
                          ? Container(
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
                                            currentuserId:
                                                widget.userId.toString(),
                                            currentproductId:
                                                snapshot.data!['message']
                                                        ['products'][
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
                                                    fontFamily:
                                                        'times-new-roman',
                                                    text: snapshot
                                                            .data!['message']
                                                        ['products'][(snapshot
                                                                    .data![
                                                                'message']
                                                            ['size']) -
                                                        i]['product_name'],
                                                    color: color,
                                                    textSize: 18,
                                                    isTitle: true,
                                                    maxLines: 1,
                                                  )),
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
                            )
                          : Container(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      // print("111111111111111111111111");
                                      // print(userId);
                                      // print("22222222222222222222222");
                                      // print(snapshot.data!['message']['products'][
                                      //         (snapshot.data!['message']['size']) - i]
                                      //     ['id']);

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                            currentuserId:
                                                widget.userId.toString(),
                                            currentproductId:
                                                snapshot.data!['message']
                                                        ['products'][
                                                    (snapshot.data!['message']
                                                            ['size']) -
                                                        i]['id'],
                                          ),
                                        ),
                                      );

                                      // Navigator.pushNamed(
                                      //   context,
                                      //   ProductDetails.routeName,
                                      //   arguments: snapshot.data!['message']
                                      //       ['products'][(snapshot.data!['message']
                                      //           ['size']) -
                                      //       i]['id'],
                                      // );
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
                                                    fontFamily:
                                                        'times-new-roman',
                                                    text: snapshot
                                                            .data!['message']
                                                        ['products'][(snapshot
                                                                    .data![
                                                                'message']
                                                            ['size']) -
                                                        i]['product_name'],
                                                    color: color,
                                                    textSize: 18,
                                                    isTitle: true,
                                                    maxLines: 1,
                                                  )),
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
                    // crossAxisSpacing: 6,
                    childAspectRatio: size.width / (size.height * 0.62),
                    children: List.generate(
                      searchproducts.length,
                      // _searchTextController.text.isNotEmpty
                      //     ? searchproducts.length
                      //     : products.length,
                      (index) {
                        return searchproducts[index];
                      },
                    ),
                  );
                } else {
                  searchproducts = const <Widget>[
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
