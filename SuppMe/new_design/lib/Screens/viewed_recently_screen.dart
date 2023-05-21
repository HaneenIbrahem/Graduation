import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../widgets/text_widget.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = "/OrdersScreen";
  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  State<ViewedRecentlyScreen> createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  @override
  Widget build(BuildContext context) {
    bool isEmpty = true;
    final Color color = Utils(context).color;
    final Size size = Utils(context).getScreenSize;
    final isDark = Utils(context).getTheme;
    // final ordersProvider = Provider.of<OrdersProvider>(context);
    // final ordersList = ordersProvider.getOrders;
    return FutureBuilder(
      // future: ordersProvider.fetchOrders(),
      builder: (context, snapshot) {
        return
            // ordersList.isEmpty
            // ? const EmptyScreen(
            //     imgName: "cart",
            //     title: "You didn't place any order yet",
            //     subTitle: "Order something and make me happy :)",
            //     buttonText: "Shop now",
            //   )
            // :
            Scaffold(
          // appBar: AppBar(
          //   elevation: 0,
          //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //   automaticallyImplyLeading: false,
          //   // leading: const BackWidget(),
          //   title: TextWidget(
          //     fontFamily: 'times-new-roman',
          //     text: 'Your Orders',
          //     color: color,
          //     isTitle: true,
          //     textSize: 24.0,
          //   ),
          // ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  Image.asset(
                    "assets/history.png",
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
                    text: "Your history is empty",
                    color: Colors.cyan,
                    textSize: 20.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextWidget(
                    fontFamily: 'times-new-roman',
                    text: "No products has been viewed yet!",
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
            ),
          ),
        );
      },
    );
  }
}
