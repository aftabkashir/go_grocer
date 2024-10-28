import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocer/inner_screens/product_details.dart';
import 'package:go_grocer/services/global_methods.dart';
import 'package:go_grocer/widgets/heart_btn.dart';
import 'package:go_grocer/widgets/text_widgets.dart';

import '../../services/utils.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.nevigateTo(
              ctx: context, routeName: ProductDetails.routeName);
        },
        child: Container(
            height: size.height * 0.20,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: color, width: 1),
                borderRadius: BorderRadius.circular(8.0)),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: size.width * 0.22,
                  height: size.width * 0.25,
                  child: FancyShimmerImage(
                    imageUrl:
                        'https://w7.pngwing.com/pngs/29/515/png-transparent-plum-fruits-apricot-apricots-natural-foods-food-fruit-thumbnail.png',
                    boxFit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconlyLight.bag2,
                              color: color,
                            ),
                          ),
                          const HeartBTN(),
                        ],
                      ),
                    ),
                    Flexible(
                      child: TextWidget(
                        text: 'Title',
                        color: color,
                        textSize: 20,
                        maxLines: 2,
                        isTitle: true,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    TextWidget(
                      text: 'RS 100',
                      color: color,
                      textSize: 18,
                      maxLines: 2,
                      isTitle: true,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
