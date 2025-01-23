import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocer/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/utils.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({super.key, required this.productId,  this.isInWishlist= false});
  final String productId;
  final bool? isInWishlist;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return GestureDetector(
      onTap: () {
        wishlistProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: Icon(
        isInWishlist != null && isInWishlist == true ? IconlyBold.heart:
        IconlyLight.heart,
        size: 22,
        color: isInWishlist != null && isInWishlist == true ? Colors.red: color,
      ),
    );
  }
}
