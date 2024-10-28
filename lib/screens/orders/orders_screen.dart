import 'package:flutter/material.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widgets.dart';
import 'orders_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
//    bool _isEmpty = true;
    return
      // _isEmpty
      //   ? const EmptyScreen(
      //       imagepath: "assets/images/cart.png",
      //       title: 'You didnt make any order yet',
      //       subtitle: 'Order something to make me happy :)',
      //       buttonText: 'Shop now',
      //     )
      //   :
    Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 0,
              centerTitle: false,
              title: TextWidget(
                text: 'Your orders (2)',
                color: color,
                textSize: 24.0,
                isTitle: true,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.separated(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrdersWidget(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: color,
                  thickness: 1,
                );
              },
            ));
  }
}
