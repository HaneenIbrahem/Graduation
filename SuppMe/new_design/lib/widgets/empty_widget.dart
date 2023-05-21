import 'package:flutter/material.dart';
// import 'package:grocery_app/inner_screens/feeds_screen.dart';
// import 'package:grocery_app/services/global_methods.dart';
import 'package:new_design/widgets/text_widget.dart';

import '../services/utils.dart';

class EmptyScreen extends StatelessWidget {
  final String imgName, title, subTitle, buttonText;
  const EmptyScreen({
    Key? key,
    required this.imgName,
    required this.title,
    required this.subTitle,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).getScreenSize;
    final isDark = Utils(context).getTheme;
    return Scaffold(
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
                "assets/images/$imgName.png",
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
                text: title,
                color: Colors.cyan,
                textSize: 20.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextWidget(
                fontFamily: 'times-new-roman',
                text: subTitle,
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
                    text: buttonText,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
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
  }
}
