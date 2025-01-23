import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocer/inner_screens/product_details.dart';
import 'package:go_grocer/models/wishlist_model.dart';
import 'package:go_grocer/providers/product_provider.dart';
import 'package:go_grocer/services/global_methods.dart';
import 'package:go_grocer/widgets/heart_btn.dart';
import 'package:go_grocer/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

import '../../providers/wishlist_provider.dart';
import '../../services/utils.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider =Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final getCurrProduct = productProvider.findProById(wishlistModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    bool? _isInWishlist = wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routeName, arguments: wishlistModel.productId);
        },
        child: Container(
            height: size.height * 0.20,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: color, width: 1),
                borderRadius: BorderRadius.circular(8.0)),
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    //width: size.width * 0.22,
                    height: size.width * 0.25,
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.imageUrl,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            HeartBTN(
                              productId: getCurrProduct.id,
                              isInWishlist: _isInWishlist,
                            ),
                          ],
                        ),
                      ),
                      TextWidget(
                        text: getCurrProduct.title,
                        color: color,
                        textSize: 20,
                        maxLines: 2,
                        isTitle: true,
                      ),
                      const SizedBox(height: 5,),
                      TextWidget(
                        text: 'RS ${usedPrice.toStringAsFixed(2)}',
                        color: color,
                        textSize: 18,
                        maxLines: 2,
                        isTitle: true,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
