// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:new_design/constant/firebase_consts.dart';
// // import 'package:grocery_app/provider/wishlist_provider.dart';
// // import 'package:grocery_app/services/global_methods.dart';
// import 'package:provider/provider.dart';

// // import '../provider/products_provider.dart';
// import '../services/global_methods.dart';
// import '../services/utils.dart';

// class HeartBTN extends StatefulWidget {
//   final String productId;
//   final bool? isInWishList;

//   const HeartBTN({
//     Key? key,
//     required this.productId,
//     this.isInWishList = false,
//   }) : super(key: key);

//   @override
//   State<HeartBTN> createState() => _HeartBTNState();
// }

// class _HeartBTNState extends State<HeartBTN> {
//   bool _isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final Color color = Utils(context).color;
//     // final wishListProvider = Provider.of<WishListProvider>(context);
//     final user = authInstance.currentUser;
//     // final productProvider = Provider.of<ProductsProvider>(context);
//     // final getCurrentProduct = productProvider.findProdById(widget.productId);
//     return GestureDetector(
//       onTap: () async {
//         // wishListProvider.addRemoveProductsToWishList(productId: productId);
//         setState(() => _isLoading = true);
//         try {
//           // if (user == null) {
//           //   // setState(() => _isLoading = false);
//           //   GlobalMethods.errorDialog(
//           //       subTitle: "No user found, Please login first",
//           //       context: context);
//           //   return;
//           // }
//           if (widget.isInWishList == false && widget.isInWishList != null) {
//             await GlobalMethods.addToWishlist(
//               productId: widget.productId,
//               context: context,
//             );
//           } else {
//             // await wishListProvider.removeOneItem(
//             //   wishlistId:
//             //       wishListProvider.getwishListItems[getCurrentProduct.id]!.id,
//             //   productId: widget.productId,
//             // );
//           }
//           // await wishListProvider.fetchWishlist();
//           setState(() => _isLoading = false);
//         } catch (error) {
//           GlobalMethods.errorDialog(subTitle: '$error', context: context);
//         } finally {
//           setState(() => _isLoading = false);
//         }
//       },
//       child: _isLoading
//           ? const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: SizedBox(
//                 height: 15.0,
//                 width: 15.0,
//                 child: CircularProgressIndicator(),
//               ),
//             )
//           : Icon(
//               widget.isInWishList != null && widget.isInWishList == true
//                   ? IconlyBold.heart
//                   : IconlyLight.heart,
//               size: 22,
//               color: widget.isInWishList != null && widget.isInWishList == true
//                   ? Colors.red
//                   : color,
//             ),
//     );
//   }
// }
