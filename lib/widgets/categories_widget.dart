import 'package:flutter/material.dart';
import 'package:go_grocer/inner_screens/cat_screen.dart';
import 'package:go_grocer/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details.dart';
import '../provider/dark_theme_provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {super.key,
      required this.catText,
      required this.imgPath,
      required this.passedcolor});
  final String catText, imgPath;
  final Color passedcolor;
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    //Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CategoryScreen.routeName, arguments: catText);
      },
      child: Container(
        //height: _screenWidth * 0.6,
        decoration: BoxDecoration(
          color: passedcolor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: passedcolor.withOpacity(0.7), width: 2),
        ),
        child: Column(
          children: [
            Container(
              height: screenWidth * 0.3,
              width: screenWidth * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        imgPath,
                      ),
                      fit: BoxFit.fill)),
            ),
            TextWidget(
              text: catText,
              color: color,
              textSize: 20,
              isTitle: true,
            ),
          ],
        ),
      ),
    );
  }
}
