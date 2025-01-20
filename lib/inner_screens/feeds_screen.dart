import 'package:flutter/material.dart';
import 'package:go_grocer/consts/constss.dart';
import 'package:go_grocer/models/products_model.dart';
import 'package:go_grocer/providers/product_provider.dart';
import 'package:go_grocer/widgets/feed_items.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/text_widgets.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = "/FeedsScreenState";
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size =Utils(context).getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;

    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: 'All Products',
          color: color,
          textSize: 26,
          isTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Field
            SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                focusNode: _searchTextFocusNode,
                controller: _searchTextController,
                onChanged: (value) {
                  setState(() {});
                },
                style: TextStyle(color: color),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.greenAccent, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.greenAccent, width: 1),
                  ),
                  hintText: "Search here",
                  hintStyle: TextStyle(color: color.withOpacity(0.5)),
                  prefixIcon: Icon(Icons.search, color: color),
                  suffix: IconButton(
                    onPressed: () {
                      _searchTextController.clear();
                      _searchTextFocusNode.unfocus();
                    },
                    icon: Icon(
                      Icons.close,
                      color: _searchTextFocusNode.hasFocus ? Colors.red : color,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: GridView.count(
                // shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                // crossAxisSpacing: 10,
                // mainAxisSpacing: 10,
                childAspectRatio: 0.79, // Adjusted aspect ratio
                children: List.generate(
                  allProducts.length,
                  (index) {
                    return   ChangeNotifierProvider.value(
                        value: allProducts[index],
                        child:  const FeedsWidget());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
