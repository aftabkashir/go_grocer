import 'package:flutter/material.dart';
import 'package:go_grocer/widgets/on_sale_widget.dart';
import 'package:go_grocer/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../providers/product_provider.dart';
import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/empty_products_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
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
        productsOnSale.isEmpty
            ?
        const EmptyProdWidget(text: 'No Products on sale yet! \nStay tuned',)
            : GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                //crossAxisSpacing: 10,
                childAspectRatio: size.width / (size.height * 0.50),
                children: List.generate(
                  productsOnSale.length,
                  (index) {
                    return ChangeNotifierProvider.value(
                        value: productsOnSale[index],
                        child: const OnSaleWidget());
                  },
                ),
              ),
      ),
    );
  }
}
