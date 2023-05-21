import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:new_design/Screens/admin.dart';
import 'package:new_design/Screens/bottomBarScreen.dart';
import 'package:new_design/Screens/cat_screen.dart';
// import 'package:new_design/Screens/chatBot.dart';
import 'package:new_design/Screens/home.dart';
// import 'package:new_design/Screens/login.dart';
// import 'package:new_design/Screens/mainPage.dart';
import 'package:new_design/Screens/order.dart';
// import 'package:new_design/Screens/success.dart';
import 'package:new_design/provider/dark_theme_provider.dart';
// import 'package:new_design/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'Screens/home.dart';
// import 'Screens/wishlist/wishlist_screen.dart';
import 'Screens/chat.dart';
import 'Screens/productDetails.dart';
import 'Screens/product_register.dart';
import 'Screens/write.dart';
// import 'Screens/bottomBarScreen.dart';
import 'Screens/products.dart';
import 'constant/theme_data.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// Future<void> main() async {
//   HttpOverrides.global = MyHttpOverrides();
//   // WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var email = prefs.getString("email");
//   print(email);
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: email == null ? Home() : BottomAppBar(),
//   ));
// }

// Future backgroundMessage(RemoteMessage message) async {
//   print('((((((((((((((()))))))))))))))');
//   print(message.notification!.body);
// }
var check, id, name, email, address;

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  check = prefs.getBool('isLoggedIn');
  id = prefs.getString('id');
  name = prefs.getString('name');
  email = prefs.getString('email');
  address = prefs.getString('address');
  if (check != null && check) {
    check = true;
  } else {
    check = false;
  }
  print(';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
  print(id);
  runApp(const MyApp());
  // FirebaseMessaging.onBackgroundMessage(backgroundMessage);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  void gettoken() async {
    final fbm = await FirebaseMessaging.instance.getToken();
    print("==================");
    print(fbm);
    print('==================');
    await FirebaseMessaging.onMessage.listen((event) {
      print('++++++++++++');
      print(event.notification!.body);
      AwesomeDialog(
          context: context,
          title: 'title',
          body: Text("${event.notification!.body}"));
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return SimpleDialog(
      //       insetPadding: EdgeInsets.zero,
      //       titlePadding: EdgeInsets.zero,
      //       contentPadding: EdgeInsets.zero,
      //       children: [
      //         Container(
      //           width: 300,
      //           height: 300,
      //         ),
      //       ],
      //     );
      //   },
      // );
    });
  }

  @override
  void initState() {
    // fbm.getToken().then((value) {
    // print(fbm);
    // });
    gettoken();
    // FirebaseMessaging.onMessage.listen((event) {
    //   print('++++++++++++');
    //   print(event.notification);
    // });

    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'SuppMe',
    //   home: BottomBarScreen(),
    //   routes: {
    //     OrdersScreen.routeName: (ctx) => const OrdersScreen(),
    //     "success": ((context) => Success()),
    //     "login": (context) => Login(),
    //     "home": (context) => Home()
    //     // "OrderScreen": (context) => OrdersScreen()
    //   },
    // );
    // return MultiProvider(providers: [
    //   ChangeNotifierProvider(
    //     create: (_) {
    //       return themeChangeProvider;
    //     },
    //   ),
    // ]);

    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const MaterialApp(
        //     debugShowCheckedModeBanner: false,
        //     home: Scaffold(
        //       body: Center(
        //         child: CircularProgressIndicator(),
        //       ),
        //     ),
        //   );
        // }
        // else if (snapshot.hasError) {
        //   return const MaterialApp(
        //     debugShowCheckedModeBanner: false,
        //     home: Scaffold(
        //       body: Center(
        //         child: Text("An error occured"),
        //       ),
        //     ),
        //   );
        // }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) {
                return themeChangeProvider;
              },
            ),
            // ChangeNotifierProvider(
            //   create: (_) {
            //     return WishListProvider();
            //   },
            // ),
          ],
          child: Consumer<DarkThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'SuppMe',
                theme: Styles.themeData(themeProvider.getDarkTheme, context),
                home: check
                    ? BottomBarScreen(
                        address: address,
                        email: email,
                        id: id,
                        name: name,
                      )
                    : Home(),
                routes: {
                  // OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
                  // FeedsScreen.routeName: (ctx) => const FeedsScreen(),
                  ProductDetails.routeName: (ctx) => const ProductDetails(),
                  ProductRegister.routeName: (ctx) => ProductRegister(),
                  Write.routeName: (ctx) => const Write(),
                  // WishListScreen.routeName: (ctx) => const WishListScreen(),
                  OrderScreen.routeName: (ctx) => OrderScreen(),
                  Product.routeName: (ctx) => const Product(),
                  // WishListScreen.routeName: (ctx) => const WishListScreen(),
                  // ViewedRecentlyScreen.routeName: (ctx) =>
                  //     const ViewedRecentlyScreen(),
                  // RegisterScreen.routeName: (ctx) => const RegisterScreen(),
                  // ForgetPasswordScreen.routeName: (ctx) =>
                  //     const ForgetPasswordScreen(),
                  CategoryScreen.routeName: (ctx) => const CategoryScreen(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
