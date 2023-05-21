import 'dart:convert';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart';
import 'package:new_design/Screens/productDetails.dart';
// import 'package:grocery_app/models/products_model.dart';
// import 'package:grocery_app/provider/products_provider.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';
import '../widgets/empty_products_widget.dart';
// import '../widgets/feed_items.dart';
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

class CategoryScreen extends StatefulWidget {
  final String? currentUserId;
  final String? catName;
  static String routeName = "/CategoryScreen";
  const CategoryScreen({Key? key, this.currentUserId, this.catName})
      : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  late Future<dynamic> futurecategories;
  // List<ProductModel> _listProductSearch = [];
  @override
  void initState() {
    super.initState();
    futurecategories = getallproduct();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int sizee, count = 0;
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    // final productsProvider = Provider.of<ProductsProvider>(context);
    // final catName = ModalRoute.of(context)!.settings.arguments as String;
    // List<ProductModel> productsByCat = productsProvider.findByCategory(catName);

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
            text: widget.catName.toString(),
            color: color,
            textSize: 20.0,
            isTitle: true,
            fontFamily: 'times-new-roman',
          ),
        ),
        body: FutureBuilder<dynamic>(
            future: futurecategories,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              List<Widget> categoriesproducts;
              if (snapshot.hasData) {
                sizee = (snapshot.data!['message']['size']);
                for (int j = 1; j <= sizee; j++) {
                  if (snapshot.data!['message']['products']
                              [(snapshot.data!['message']['size']) - j]
                          ['product_category_name'] ==
                      widget.catName.toString()) {
                    count++;
                  }
                }
                if (count == 0) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50.0,
                        ),
                        Image.asset(
                          "assets/box.png",
                          width: double.infinity,
                          height: size.height * 0.4,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: Text(
                            'No products belong \n   to this category',
                            style: TextStyle(
                              color: color,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // for (int j = 1; j <= sizee; j++)
                  categoriesproducts = <Widget>[
                    for (int i = 1; i <= sizee; i++)
                      if (snapshot.data!['message']['products']
                                  [(snapshot.data!['message']['size']) - i]
                              ['product_category_name'] ==
                          widget.catName.toString())
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
                                        currentuserId:
                                            widget.currentUserId.toString(),
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
                      categoriesproducts.length < 40
                          ? categoriesproducts.length
                          : 4,
                      (index) {
                        return categoriesproducts[index];
                      },
                    ),
                  );
                }
              } else {
                categoriesproducts = const <Widget>[
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
                );
              }
            })

        // productsByCat.isEmpty
        //     ? const EmptyProductWidget(
        //         text: 'No products belong to this category')
        //     : SingleChildScrollView(
        //         child: Column(
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: SizedBox(
        //                 height: kBottomNavigationBarHeight,
        //                 child: TextField(
        //                   focusNode: _searchTextFocusNode,
        //                   controller: _searchTextController,
        //                   onChanged: (value) {
        //                     setState(
        //                       () {
        //                         _listProductSearch =
        //                             productsProvider.searchQuery(value);
        //                       },
        //                     );
        //                   },
        //                   decoration: InputDecoration(
        //                     focusedBorder: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(12),
        //                       borderSide: const BorderSide(
        //                         color: Colors.greenAccent,
        //                         width: 1,
        //                       ),
        //                     ),
        //                     enabledBorder: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(12),
        //                       borderSide: const BorderSide(
        //                         color: Colors.greenAccent,
        //                         width: 1,
        //                       ),
        //                     ),
        //                     hintText: "Search...",
        //                     prefixIcon: const Icon(Icons.search),
        //                     suffixIcon: Visibility(
        //                       visible:
        //                           _searchTextFocusNode.hasFocus ? true : false,
        //                       child: IconButton(
        //                         onPressed: () {
        //                           _searchTextController.clear();
        //                           _searchTextFocusNode.unfocus();
        //                         },
        //                         icon: Icon(
        //                           Icons.close,
        //                           color: _searchTextFocusNode.hasFocus
        //                               ? Colors.red
        //                               : color,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             _searchTextController.text.isNotEmpty &&
        //                     _listProductSearch.isEmpty
        //                 ? const EmptyProductWidget(
        //                     text: 'No products found, please try another keyword',
        //                   )
        //                 : GridView.count(
        //                     shrinkWrap: true,
        //                     physics: const NeverScrollableScrollPhysics(),
        //                     crossAxisCount: 2,
        //                     padding: EdgeInsets.zero,
        //                     // crossAxisSpacing: 10,
        //                     childAspectRatio: size.width / (size.height * 0.62),
        //                     children: List.generate(
        //                       _searchTextController.text.isNotEmpty
        //                           ? _listProductSearch.length
        //                           : productsByCat.length,
        //                       (index) {
        //                         return ChangeNotifierProvider.value(
        //                           value: _searchTextController.text.isNotEmpty
        //                               ? _listProductSearch[index]
        //                               : productsByCat[index],
        //                           child: const FeedsWidget(),
        //                         );
        //                       },
        //                     ),
        //                   ),
        //           ],
        //         ),
        // ),
        );
  }
}
