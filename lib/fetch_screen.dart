import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_grocer/consts/firebase_consts.dart';
import 'package:go_grocer/providers/cart_provider.dart';
import 'package:go_grocer/providers/product_provider.dart';
import 'package:go_grocer/screens/btm_bar.dart';
import 'package:provider/provider.dart';

import 'consts/constss.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  List<String> images = Constss.authImagesPaths;
  @override
  void initState() {
    images.shuffle();
    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider =
      Provider.of<CartProvider>(context, listen: false);
      final User? user= authInstance.currentUser;
      if(user ==null ){
        await productsProvider.fetchProducts();
        cartProvider.clearCart();
      }else
        {
          await productsProvider.fetchProducts();
          await cartProvider.fetchCart();
        }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => const BottomBarScreen(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            images[0],
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
