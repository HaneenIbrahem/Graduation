import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'dart:js_util';
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

Future<dynamic> updateproduct(
  String userid,
  String productId,
  String projectName,
  String imageUrl,
  String projectCategoryName,
  String price,
  String salePrice,
  String description,
) async {
  Response response = await post(
      Uri.parse("https://doniaserver1.000webhostapp.com/edit_product.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'user_id': userid,
        'product_id': productId,
        'product_name': projectName,
        'image_url': imageUrl,
        'product_category_name': projectCategoryName,
        'sale_price': salePrice,
        'price': price,
        'description': description,
      }));
  var jsonResponse = jsonDecode(response.body);
  print("**************************************************");
  print(jsonResponse.toString());
  print(jsonResponse.toString());
  print(jsonResponse.toString());
  if (jsonResponse['status'] == "success") {
    // Navigator.of(context).pop();
    print("Success: ");
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

String dropdownvalue = 'Food';
// List of items in our dropdown menu
var items = ['Food', 'Clothes', 'Embroidery', 'Art', 'Makeup', 'Clay'];

class ProductUserDetails extends StatefulWidget {
  final String? userId;
  final String? productId;
  final String? userName;
  final String? userEmail;
  static const String routeName = "/ProductUserDetails";
  ProductUserDetails(
      {Key? key, this.userId, this.userName, this.userEmail, this.productId})
      : super(key: key);
  @override
  State<ProductUserDetails> createState() => _ProductUserDetailsState();
}

class _ProductUserDetailsState extends State<ProductUserDetails> {
  GlobalKey<FormState> formstate = GlobalKey();
  late Future<dynamic> futureproducts;
  // bool _isLoading = false;
  TextEditingController projectName = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
  TextEditingController projectCategoryName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureproducts = getallproduct();
    imageUrl.text =
        'https://firebasestorage.googleapis.com/v0/b/suppme-44042.appspot.com/o/images%2Fscaled_image_picker7030534172292019770.jpg?alt=media&token=b2397bda-bbca-4a7f-bbd2-d8d27d10ac64';
  }

  File? imageFile;
  var imagepicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    // var dropdownvalue;
    int sizee;
    final Color color = Utils(context).color;
    final isDark = Utils(context).getTheme;
    final Size size = Utils(context).getScreenSize;
    // final usertId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: FutureBuilder<dynamic>(
                  future: futureproducts,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    List<Widget> products;
                    if (snapshot.hasData) {
                      sizee = (snapshot.data!['message']['size']);
                      // for (int j = 0; j < sizee; j++)
                      //   if ((snapshot.data!['message']['products'][j]['id']) ==
                      //       widget.productId)
                      //     imageUrl.text = (snapshot.data!['message']['products']
                      //         [j]['image_url']);
                      // for (int k = 0; k < sizee; k++)
                      //   if ((snapshot.data!['message']['products'][k]['id']) ==
                      //       widget.productId)
                      //     dropdownvalue = (snapshot.data!['message']['products']
                      //         [k]['product_category_name']);
                      products = <Widget>[
                        // dropdownvalue =
                        //     snapshot.data!['message']['products'][1]['id'],
                        for (int i = 0; i < sizee; i++)
                          if ((snapshot.data!['message']['products'][i]
                                  ['id']) ==
                              widget.productId)
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                head(),
                                const SizedBox(height: 0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0, bottom: 5.0),
                                        child: Text(
                                          'Name of your product',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: color,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'times-new-roman',
                                          ),
                                        ),
                                      ),
                                      // buildname(projectName),
                                      TextFormField(
                                        // initialValue: snapshot.data!['message']
                                        //     ['products'][i]['product_name'],
                                        keyboardType: TextInputType.name,
                                        controller: projectName,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 90, 96, 105)),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 0.5,
                                              color: Color.fromARGB(
                                                  255, 226, 204, 204),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder:
                                              GradientOutlineInputBorder(
                                            width: 3.0,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 80, 160, 180),
                                                  Color.fromARGB(
                                                      255, 51, 66, 73)
                                                ]),
                                          ),
                                          // prefixIcon:
                                          //     const Icon(Icons.person, color: Color.fromARGB(255, 90, 96, 105)),
                                          // filled: true,
                                          // fillColor: const Color.fromRGBO(30, 30, 30, .51),
                                        ),
                                        // onChanged: ((value) {
                                        //   controller:
                                        //   value;
                                        // }),
                                      ),
                                      const SizedBox(height: 6),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0, bottom: 5.0),
                                        child: Text(
                                          'Description',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: color,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'times-new-roman',
                                          ),
                                        ),
                                      ),
                                      // builddescription(description),
                                      TextFormField(
                                        // initialValue: snapshot.data!['message']
                                        //     ['products'][i]['description'],
                                        keyboardType: TextInputType.text,
                                        maxLines: 4,
                                        controller: description,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 90, 96, 105)),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 0.5,
                                              color: Color.fromARGB(
                                                  255, 226, 204, 204),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder:
                                              GradientOutlineInputBorder(
                                            width: 3.0,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 80, 160, 180),
                                                  Color.fromARGB(
                                                      255, 51, 66, 73)
                                                ]),
                                          ),
                                          // prefixIcon:
                                          //     const Icon(Icons.person, color: Color.fromARGB(255, 90, 96, 105)),
                                          // filled: true,
                                          // fillColor: const Color.fromRGBO(30, 30, 30, .51),
                                        ),
                                        // onChanged: ((description) {
                                        //   controller:
                                        //   description;
                                        // }),
                                      ),
                                      const SizedBox(height: 6),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0, bottom: 5.0),
                                        child: Text(
                                          'Price',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: color,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'times-new-roman',
                                          ),
                                        ),
                                      ),
                                      // buildprice(price),
                                      TextFormField(
                                        // initialValue: snapshot.data!['message']
                                        //     ['products'][i]['price'],
                                        keyboardType: TextInputType.number,
                                        controller: price,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 90, 96, 105)),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 0.5,
                                              color: Color.fromARGB(
                                                  255, 226, 204, 204),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder:
                                              GradientOutlineInputBorder(
                                            width: 3.0,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 80, 160, 180),
                                                  Color.fromARGB(
                                                      255, 51, 66, 73)
                                                ]),
                                          ),
                                          // prefixIcon:
                                          //     const Icon(Icons.person, color: Color.fromARGB(255, 90, 96, 105)),
                                          // filled: true,
                                          // fillColor: const Color.fromRGBO(30, 30, 30, .51),
                                        ),
                                        // onChanged: ((price) {
                                        //   controller:
                                        //   price;
                                        // }),
                                      ),
                                      const SizedBox(height: 6),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0, bottom: 5.0),
                                        child: Text(
                                          'Category type',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: color,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'times-new-roman',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 30.0, bottom: 5.0),
                                        child: DropdownButton(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: color,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'times-new-roman',
                                          ),
                                          value: dropdownvalue,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: items.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownvalue = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, bottom: 5.0),
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                20,
                                              ),
                                            ),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 226, 204, 204),
                                              width: 0.5,
                                            ),
                                          ),
                                          child: GestureDetector(
                                            child: _getMediaWidget(),
                                            onTap: () {
                                              _showPicker(context)();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(right: 00.0),
                                  child: Container(
                                    width: 370,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color.fromARGB(255, 90, 96, 105),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color.fromARGB(255, 80, 160, 180),
                                            Color.fromARGB(255, 80, 160, 180)
                                          ]),
                                    ),
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      onPressed: () async {
                                        // await uploadImages();
                                        if (projectName.text!.isEmpty) {
                                          print("Name field is missing");
                                          warningDialog(
                                              title: "Error",
                                              subTitle: "Name field is missing",
                                              context: context);
                                          return;
                                        }
                                        if (description.text!.isEmpty) {
                                          print("Description field is missing");
                                          warningDialog(
                                              title: "Error",
                                              subTitle:
                                                  "Description field is missing",
                                              context: context);
                                          return;
                                        }
                                        if (price.text!.isEmpty) {
                                          print("Price field is missing");
                                          warningDialog(
                                              title: "Error",
                                              subTitle:
                                                  "Price field is missing",
                                              context: context);
                                          return;
                                        }
                                        if (dropdownvalue.toString()!.isEmpty) {
                                          print(
                                              "Category type field is missing");
                                          warningDialog(
                                              title: "Error",
                                              subTitle:
                                                  "Category type field is missing",
                                              context: context);
                                          return;
                                        }

                                        // var imgurl = await await _getFromCamera();
                                        print(
                                            "++++++++++++++++++++++++++++++++++++++++++++++++++");
                                        print(projectName.text);
                                        print(imageUrl.text);
                                        // imageFile!.path,
                                        print(dropdownvalue.toString());
                                        print(price.text);
                                        print(salePrice.text);
                                        print(description.text);

                                        if (imageUrl.text.isEmpty) {
                                          print("Picture is missing");
                                          warningDialog(
                                              title: "Error",
                                              subTitle: "Picture is missing",
                                              context: context);
                                          return;
                                        }
                                        await updateproduct(
                                            widget.userId.toString(),
                                            widget.productId.toString(),
                                            projectName.text,
                                            imageUrl.text,
                                            dropdownvalue.toString(),
                                            price.text.toString(),
                                            "0",
                                            description.text);

                                        // Navigator.of(context).pushReplacement(
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         BottomBarScreen(),
                                        //   ),
                                        // );
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BottomBarScreen(
                                              id: widget.userId.toString(),
                                              name: widget.userName,
                                              email:
                                                  widget.userEmail.toString(),
                                              // currentIndex: 0,
                                            ),
                                          ),
                                        );
                                        // }

                                        // print("imageFile");
                                        // print(imageFile);
                                      },
                                      child: Row(
                                        children: const [
                                          Center(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 125),
                                              child: Text(
                                                'Update',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'times-new-roman',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                        // ),
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.orange)),
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward,
                ),
                leading: const Icon(
                  Icons.camera,
                ),
                title: Text("From Gallery"),
                onTap: () async {
                  await await _getFromGallery();
                  // PickedFile? pickedFile = await await ImagePicker().getImage(
                  //   source: ImageSource.gallery,
                  //   imageQuality: 15,
                  //   maxWidth: 1800,
                  //   maxHeight: 1800,
                  // );
//                   if (pickedFile != null) {
//                     File imageFile = File(pickedFile.path);
//                     // return imageFile;
//                     var nameImage = basename(imageFile.path);
// // start upload to firebase
//                     var refstorage =
//                         FirebaseStorage.instance.ref("images/$nameImage");
//                     await refstorage.putFile(imageFile!);
//                     imageUrl.text = await await refstorage.getDownloadURL();
//                   } else {
//                     print("please choose image");
//                   }
                  Navigator.of(context).pop();

                  // dismiss the bottomsheet
                },
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward,
                ),
                leading: const Icon(
                  Icons.camera_alt_outlined,
                ),
                title: Text("From Camera"
                    // AppStrings.photoCamera.tr(),
                    ),
                onTap: () async {
                  await await _getFromCamera();
                  // dismiss the bottomsheet
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 15,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      // return imageFile;
      var nameImage = basename(imageFile.path);
// start upload to firebase
      var refstorage = FirebaseStorage.instance.ref("images/$nameImage");
      await refstorage.putFile(imageFile!);
      imageUrl.text = await await refstorage.getDownloadURL();
    } else {
      print("please choose image");
    }
    // return urll;
  }

  /// Get from camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 15,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      var nameImage = basename(imageFile.path);
// start upload to firebase
      var refstorage = FirebaseStorage.instance.ref("images/$nameImage");
      await refstorage.putFile(imageFile!);
      imageUrl.text = await refstorage.getDownloadURL();
      print("url: ");
      print(imageUrl.text);
    } else {
      print("please choose image");
    }
    // return urll;
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            child: Text("Picture"),
          ),
          // InkWell(
          //     onTap: () {
          //       print("hi from image");
          //     },
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(20.0),
          //       child:
          Image.network(
            imageUrl.text,
            width: 170,
          ),
          // )),
          Flexible(
            child: StreamBuilder<File>(
              // stream: _registerViewModel.outputProfilePicture,
              builder: (context, snapshot) {
                return _imagePickedByUser(snapshot.data);
              },
            ),
          ),
          Flexible(
            child: SvgPicture.asset(
              ImageAssets.photoCameraIc,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _imagePickedByUser(File? image) {
  if (image != null && image.path.isNotEmpty) {
    // return image
    return Image.file(image);
  } else {
    return Container();
  }
}

Widget head() => Padding(
      padding: const EdgeInsets.only(
        bottom: 0.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 10,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(60),
                bottomLeft: Radius.circular(60),
              ),
            ),
          ),
          const Text(
            'SuppMe',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 62, 90, 116),
              fontFamily: 'Pacifico-Regular',
              fontSize: 35,
            ),
          ),
        ],
      ),
    );

class ImageAssets {
  static const String photoCameraIc = "assets/photo-camera.svg";
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
