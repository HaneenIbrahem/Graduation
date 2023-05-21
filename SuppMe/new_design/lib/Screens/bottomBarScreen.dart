// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';

// class MainPage extends StatelessWidget {
//   MainPage({Key? key}) : super(key: key);
//   // final email = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//       elevation: 0,
//       backgroundColor: Color.fromARGB(200, 20, 100, 10),
//       // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       title: Text('Cart '),
//       //  color: Color.fromARGB(20, 200, 10, 100),
//       // isTitle: true,
//       // textSize: 22,
//       // ),
//       actions: [
//         IconButton(
//           onPressed: () {},
//           icon: Icon(
//             IconlyBroken.delete,
//             color: Color.fromARGB(20, 200, 10, 100),
//           ),
//         ),
//       ],
//     ));
//   }
// }
/************************************************* */
import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:new_design/Screens/Categories.dart';
import 'package:new_design/Screens/cart.dart';
import 'package:new_design/Screens/chatBot.dart';
import 'package:new_design/Screens/home.dart';
import 'package:new_design/Screens/mainPage.dart';
import 'package:new_design/Screens/product_register.dart';
import 'package:new_design/Screens/signup.dart';
import 'package:new_design/Screens/success.dart';
import 'package:new_design/Screens/user.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class BottomBarScreen extends StatefulWidget {
  final String? email;
  final String? name;
  final String? id;
  final String? address;
  // BottomBarScreen({this.name, this.email});
  const BottomBarScreen(
      {Key? key, this.name, this.email, this.id, this.address})
      : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  late String? eml;
  late String? nam;
  late String? id;
  late String? address;

  initialMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => SignUp()));
    }
  }

  @override
  void initState() {
    super.initState();
    eml = widget.email.toString();
    nam = widget.name.toString();
    id = widget.id.toString();
    address = widget.address.toString();
    print("objecttttttttttttttttttttttt");
    print(address);

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Success()));
    });
    initialMessage();
  }
  // LevelUp() {
  // eml = widget.email.toString();
  //   nam = widget.name.toString();
  // }

  // e = widget.email.toString();
  // ignore: prefer_final_fields
  List<Map<String, dynamic>> _pages = [
    {
      'page': MainPage(),
      'title': 'Home Screen',
    },
    {
      'page': Categories(),
      'title': 'Categories Screen',
    },
    {
      'page': Cart(),
      'title': 'Cart Screen',
    },
    {
      'page': ChatBot(),
      'title': 'Chat Screen',
    },
    {
      'page': UserScreen(),
      'title': 'User Screen',
    },
  ];
  void _selectedPage(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    eml = widget.email.toString();
    nam = widget.name.toString();
    id = widget.id.toString();
    address = widget.address.toString();

    final themeState = Provider.of<DarkThemeProvider>(context);
    // final cartProvider = Provider.of<CartProvider>(context);
    bool isDark = themeState.getDarkTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text( _pages[_selectedIndex]['title']),
      // ),
      body: _selectedIndex == 0
          ? MainPage(currentUserId: id)
          : _selectedIndex == 1
              ? Categories(
                  currentUserId: id,
                )
              : _selectedIndex == 2
                  ? Cart(
                      userId: id,
                      userName: nam,
                      userEmail: eml,
                      address: address)
                  : _selectedIndex == 3
                      ? ChatBot()
                      : UserScreen(
                          name: nam, email: eml, id: id, address: address),

      // _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: isDark ? Colors.white10 : Colors.grey,
        selectedItemColor:
            isDark ? Color.fromARGB(255, 80, 160, 180) : Colors.black87,
        backgroundColor: isDark ? Theme.of(context).cardColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _selectedPage,
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1 ? IconlyBold.category : IconlyLight.category,
            ),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3 ? IconlyBold.chat : IconlyLight.chat,
            ),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 4 ? IconlyBold.user2 : IconlyLight.user2,
            ),
            label: "User",
          ),
        ],
      ),
    );
  }
}
/******************************************************************* */
// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:new_design/Screens/Categories.dart';
// import 'package:new_design/Screens/cart.dart';
// import 'package:new_design/Screens/chatBot.dart';
// import 'package:new_design/Screens/home.dart';
// import 'package:new_design/Screens/mainPage.dart';
// import 'package:new_design/Screens/product_register.dart';
// import 'package:new_design/Screens/user.dart';
// import 'package:provider/provider.dart';

// import '../provider/dark_theme_provider.dart';

// class BottomBarScreen extends StatefulWidget {
//   final String? email;
//   final String? name;
//   final String? id;
//   final String? address;
//   final int currentIndex;
//   // BottomBarScreen({this.name, this.email});
//   const BottomBarScreen(
//       {Key? key,
//       this.name,
//       this.email,
//       this.id,
//       this.address,
//       required this.currentIndex})
//       : super(key: key);

//   @override
//   State<BottomBarScreen> createState() => _BottomBarScreenState();
// }

// class _BottomBarScreenState extends State<BottomBarScreen> {
//   late int _selectedIndex;
//   late String? eml;
//   late String? nam;
//   late String? id;
//   late String? address;
//   @override
//   void initState() {
//     _selectedIndex = widget.currentIndex;
//     super.initState();
//     eml = widget.email.toString();
//     nam = widget.name.toString();
//     id = widget.id.toString();
//     address = widget.address.toString();
//     print("objecttttttttttttttttttttttt");
//     print(address);
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//   // LevelUp() {
//   // eml = widget.email.toString();
//   //   nam = widget.name.toString();
//   // }

//   // e = widget.email.toString();
//   // ignore: prefer_final_fields
//   // List<Map<String, dynamic>> _pages = [
//   //   {
//   //     'page': MainPage(),
//   //     'title': 'Home Screen',
//   //   },
//   //   {
//   //     'page': Categories(),
//   //     'title': 'Categories Screen',
//   //   },
//   //   {
//   //     'page': Cart(),
//   //     'title': 'Cart Screen',
//   //   },
//   //   {
//   //     'page': ChatBot(),
//   //     'title': 'Chat Screen',
//   //   },
//   //   {
//   //     'page': UserScreen(),
//   //     'title': 'User Screen',
//   //   },
//   // ];
//   // void _selectedPage(int index) {
//   //   setState(
//   //     () {
//   //       _selectedIndex = index;
//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     eml = widget.email.toString();
//     nam = widget.name.toString();
//     id = widget.id.toString();
//     address = widget.address.toString();

//     final themeState = Provider.of<DarkThemeProvider>(context);
//     // final cartProvider = Provider.of<CartProvider>(context);
//     bool isDark = themeState.getDarkTheme;
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text( _pages[_selectedIndex]['title']),
//       // ),
//       // body: _selectedIndex == 0
//       //     ? MainPage(currentUserId: id)
//       //     : _selectedIndex == 1
//       //         ? Categories(
//       //             currentUserId: id,
//       //           )
//       //         : _selectedIndex == 2
//       //             ? Cart(userId: id,
//       //             userName: nam,
//       //             userEmail: eml,
//       //             address: address)
//       //             : _selectedIndex == 3
//       //                 ? ChatBot()
//       //                 : UserScreen(
//       //                     name: nam, email: eml, id: id, address: address),

//       // _pages[_selectedIndex]['page'],
//       bottomNavigationBar: BottomNavigationBar(
//         unselectedItemColor: isDark ? Colors.white10 : Colors.grey,
//         selectedItemColor:
//             isDark ? Color.fromARGB(255, 80, 160, 180) : Colors.black87,
//         backgroundColor: isDark ? Theme.of(context).cardColor : Colors.white,
//         type: BottomNavigationBarType.fixed,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         onTap: _onItemTapped,
//         currentIndex: _selectedIndex,
//         elevation: 0,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(
//               _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home,
//             ),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               _selectedIndex == 1 ? IconlyBold.category : IconlyLight.category,
//             ),
//             label: "Categories",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
//             ),
//             label: "Cart",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               _selectedIndex == 3 ? IconlyBold.chat : IconlyLight.chat,
//             ),
//             label: "Chat",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               _selectedIndex == 4 ? IconlyBold.user2 : IconlyLight.user2,
//             ),
//             label: "User",
//           ),
//         ],
//       ),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: [
//           MainPage(currentUserId: id, currentIndex: _selectedIndex),
//           Categories(
//             currentIndex: 1,
//             currentUserId: id,
//           ),
//           Cart(
//               userId: id,
//               currentIndex: 2,
//               userName: nam,
//               userEmail: eml,
//               address: address),
//           ChatBot(currentIndex: 3),
//           UserScreen(
//               name: nam, email: eml, id: id, address: address, currentIndex: 4),
//         ],
//       ),
//     );
//   }
// }
