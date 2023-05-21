import 'package:flutter/material.dart';
import 'package:new_design/widgets/categories_widget.dart';
import 'package:new_design/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import 'cat_screen.dart';

// ign, String? userId, String? userId, String? userIdore: must_be_immutable
class Categories extends StatefulWidget {
  final String? currentUserId;
  // final int currentIndex;
  Categories({
    Key? key,
    this.currentUserId,
    //  required this.currentIndex
  }) : super(key: key);
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

  List<Map<String, dynamic>> catInfo = [
    {
      'imgName': 'Food',
      'catText': 'Food',
    },
    {
      'imgName': 'Clothes',
      'catText': 'Clothes',
    },
    {
      'imgName': 'Embroidery',
      'catText': 'Embroidery',
    },
    {
      'imgName': 'Art',
      'catText': 'Art',
    },
    {
      'imgName': 'Makeup',
      'catText': 'Makeup',
    },
    {
      'imgName': 'Clay',
      'catText': 'Clay',
    },
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeState = Provider.of<DarkThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final utils = Utils(context);
    // Color color = utils.color;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          fontFamily: 'times-new-roman',
          text: 'Categories',
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240 / 250,
          crossAxisSpacing: 10, // Vertical spacing
          mainAxisSpacing: 10, // Horizontal spacing
          children: List.generate(
            6,
            (index) {
              return InkWell(
                onTap: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   CategoryScreen.routeName,
                  //   arguments: catInfo[index]['catText'],
                  // );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                        currentUserId: widget.currentUserId.toString(),
                        catName: catInfo[index]['catText'],
                      ),
                    ),
                  );
                },
                child: Container(
                  // height: screenWidth * 0.6,
                  decoration: BoxDecoration(
                    color: gridColors[index].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: gridColors[1].withOpacity(0.7),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Container for the image

                      Container(
                        height: screenWidth * 0.4,
                        width: screenWidth * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/${catInfo[index]['imgName']}.png",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      // Category name
                      TextWidget(
                        fontFamily: 'times-new-roman',
                        text: catInfo[index]['catText'],
                        color: color,
                        textSize: 20,
                        isTitle: true,
                      ),
                    ],
                  ),
                ),
              );
              // CategoriesWidget(
              //   catText: catInfo[index]['catText'],
              //   imgPath: "assets/${catInfo[index]['imgName']}.png",
              //   passedColor: gridColors[index],
              // );
            },
          ),
        ),
      ),
    );
  }
}
