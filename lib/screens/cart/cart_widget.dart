import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_grocer/models/cart_model.dart';
import 'package:go_grocer/providers/product_provider.dart';
import 'package:go_grocer/widgets/heart_btn.dart';
import 'package:go_grocer/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

import '../../inner_screens/product_details.dart';
import '../../providers/cart_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key, required this.q});
  final int q;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {

    _quantityTextController.text = widget.q.toString(); //${widget.quantity}
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurrProduct = productProvider.findProById(cartModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    double totalPrice =usedPrice* int.parse(_quantityTextController.text);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName, arguments: cartModel.productId);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      height: size.width * 0.25,
                      width: size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: FancyShimmerImage(
                        imageUrl: getCurrProduct.imageUrl,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Flexible(
                      flex: 10,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: getCurrProduct.title,
                            color: color,
                            textSize: 24,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _quantityController(
                                  fct: () {
                                    if(_quantityTextController.text == '1'){
                                      return;
                                    }else {
                                      cartProvider.reduceQuantityByOne(cartModel.productId);
                                      setState(() {
                                      _quantityTextController.text = (int.parse(
                                          _quantityTextController.text) -
                                          1)
                                          .toString();
                                    });
                                    }
                                  },
                                  color: Colors.red,
                                  icon: CupertinoIcons.minus,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: TextField(
                                    controller: _quantityTextController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: color, fontSize: 20),
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]')),
                                    ],
                                    onChanged: (v) {
                                      setState(() {
                                        if (v.isEmpty) {
                                          _quantityTextController.text = '1';
                                        } else {
                                          return;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                _quantityController(
                                  fct: () {
                                    cartProvider.increaseQuantityByOne(cartModel.productId);
                                    setState(() {
                                      _quantityTextController.text = (int.parse(
                                                  _quantityTextController.text) +
                                              1)
                                          .toString();
                                    });
                                  },
                                  color: Colors.green,
                                  icon: CupertinoIcons.plus,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              cartProvider.removeOneItem(cartModel.productId);
                            },
                            child: const Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const HeartBTN(),
                          TextWidget(
                            text: 'Rs: ${usedPrice.toStringAsFixed(2)}',
                            color: color,
                            textSize: 18,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            fct();
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
