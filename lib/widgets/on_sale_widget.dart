import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocer/services/utils.dart';
import 'package:go_grocer/widgets/price_widget.dart';
import 'package:go_grocer/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details.dart';
import '../models/products_model.dart';
import '../providers/cart_provider.dart';
import '../services/global_methods.dart';
import 'heart_btn.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({super.key});

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName, arguments: productModel.id);
            // GlobalMethods.nevigateTo(
            // ctx: context, routeName: ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: productModel.imageUrl,
                      height: size.width * 0.22,
                      width: size.width * 0.22,
                      boxFit: BoxFit.fill,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        TextWidget(
                          text: productModel.isPiece? '1Pcs':'1Kg',
                          color: color,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                cartProvider.addProductsTocart(
                                  productId: productModel.id,
                                  quantity: 1,
                                );
                              },
                              child: Icon(
                                IconlyLight.bag2,
                                size: 22,
                                color: color,
                              ),
                            ),
                            const HeartBTN(),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                PriceWidget(
                  salePrice: productModel.salePrice,
                  price: productModel.price,
                  textPrice: '1',
                  isOnSale: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  text: productModel.title,
                  color: color,
                  textSize: 16,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
