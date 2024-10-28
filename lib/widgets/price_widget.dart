import 'package:flutter/material.dart';
import 'package:go_grocer/widgets/text_widgets.dart';

import '../services/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key,
      required this.salePrice,
      required this.price,
      required this.textPrice,
      required this.isOnSale});

  final double salePrice, price;
  final String textPrice;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    double usedPrice = isOnSale? salePrice : price;
    return FittedBox(
      child: Row(
        children: [
          TextWidget(
            text: 'Rs:${(usedPrice*int.parse(textPrice)).toStringAsFixed(0)}',
            color: Colors.green,
            textSize: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Visibility(
            visible: isOnSale? true: false,
            child: Text(
              'Rs:${(price*int.parse(textPrice)).toStringAsFixed(0)}',
              style: TextStyle(
                  fontSize: 15,
                  color: color,
                  decoration: TextDecoration.lineThrough),
            ),
          ),
        ],
      ),
    );
  }
}
