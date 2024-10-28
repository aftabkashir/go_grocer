import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:go_grocer/widgets/text_widgets.dart';

import '../../inner_screens/product_details.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return ListTile(
      subtitle: const Text('Paid: RS 100'),
      onTap: (){
        GlobalMethods.nevigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      leading: FancyShimmerImage(
          width: size.width*0.2,
          imageUrl:
          'https://w7.pngwing.com/pngs/29/515/png-transparent-plum-fruits-apricot-apricots-natural-foods-food-fruit-thumbnail.png',
        ),
      title: TextWidget(text: 'Title x12', color: color, textSize: 18),
      trailing: TextWidget(text: '18/09/2024', color: color, textSize: 18),
    );
  }
}
