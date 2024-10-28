import 'package:flutter/material.dart';
import 'package:go_grocer/widgets/on_sale_widget.dart';
import 'package:go_grocer/widgets/text_widgets.dart';

import '../services/utils.dart';
import '../widgets/back_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: 'Products on Sale',
          color: color,
          textSize: 26,
          isTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        isEmpty
            ?
        Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Image.asset('assets/images/box.png'),
                    ),
                    Text(
                      'No Products on sale yet! \nStay tuned',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: color,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                //crossAxisSpacing: 10,
                childAspectRatio: size.width / (size.height * 0.50),
                children: List.generate(
                  16,
                  (index) {
                    return const OnSaleWidget();
                  },
                ),
              ),
      ),
    );
  }
}
