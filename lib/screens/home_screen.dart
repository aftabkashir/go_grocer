import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../consts/constss.dart';
import '../inner_screens/cat_screen.dart';
import '../inner_screens/feeds_screen.dart';
import '../inner_screens/on_sale_screen.dart';
import '../models/products_model.dart';
import '../providers/product_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import '../widgets/feed_items.dart';
import '../widgets/on_sale_widget.dart';
import '../widgets/text_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  final List<Map<String, dynamic>> catInfo = [
    {'imgPath': 'assets/images/cat/fruits.png', 'catText': 'Fruits'},
    {'imgPath': 'assets/images/cat/veg.png', 'catText': 'Vegetables'},
    {'imgPath': 'assets/images/cat/Spinach.png', 'catText': 'Herbs'},
    {'imgPath': 'assets/images/cat/nuts.png', 'catText': 'Nuts'},
    {'imgPath': 'assets/images/cat/spices.png', 'catText': 'Spices'},
    {'imgPath': 'assets/images/cat/grains.png', 'catText': 'Grains'},
  ];

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = Utils(context).color;
    Size size = utils.getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale= productProviders.getOnSaleProducts;
    // final catName = ModalRoute.of(context)!.settings.arguments as String;
    // List<ProductModel> productByCat = productProviders.findByCategory(catName);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Background container wrapping top content
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              // Use card color as the background
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    // Logo at the top
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: size.width * 0.12,
                          width: size.height * 1,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),

                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 5, right: 20, bottom: 5),
                      child: SizedBox(
                        height: 60,
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
                              borderSide: const BorderSide(
                                  color: Colors.greenAccent, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Colors.greenAccent, width: 2),
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
                                color: _searchTextFocusNode.hasFocus
                                    ? Colors.red
                                    : color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5,),

            // Categories Section
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: 'Categories',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: catInfo.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        // Handle category tap
                        Navigator.pushNamed(
                            context,
                            CategoryScreen.routeName,
                            arguments: catInfo[index]['catText'],
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage(catInfo[index]['imgPath']),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            catInfo[index]['catText'],
                            style: TextStyle(color: color, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 5),

            // Custom Swiper
            SizedBox(
              height: size.height * 0.25,
              width: size.width * 1,
              child: Swiper(
                loop: true, // Ensures infinite looping
                viewportFraction:
                    0.8, // Shrinks each item slightly to show parts of adjacent ones
                scale: 0.9,
                layout: SwiperLayout.STACK,
                autoplay: true,
                customLayoutOption: CustomLayoutOption(
                  startIndex: 2,
                  stateCount: 3,
                )
                  ..addRotate([
                    -60.0 / 180 * 3.14,
                    0.0,
                    -40.0 / 180 * 3.14,
                  ])
                  ..addTranslate([
                    const Offset(-370.0, -40.0),
                    const Offset(0.0, 0.0),
                    const Offset(370.0, -40.0),
                  ]),
                itemWidth: 380.0,
                itemHeight: 150.0,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius:
                        BorderRadius.circular(15), // Apply border radius
                    child: Container(
                      color: Colors.black,
                      child: Image.asset(
                        Constss.offerImages[index], // Your offer images here
                        fit: BoxFit
                            .cover, // Ensure the image covers the entire area
                      ),
                    ),
                  );
                },
                itemCount: Constss.offerImages.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Sale products',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  TextButton(
                    onPressed: () {
                      GlobalMethods.nevigateTo(
                          ctx: context, routeName: OnSaleScreen.routeName);
                    },
                    child: TextWidget(
                      text: 'View all',
                      maxLines: 1,
                      color: Colors.blue,
                      textSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: 'On sale'.toUpperCase(),
                        color: Colors.red,
                        textSize: 22,
                        isTitle: true,
                      ),
                      const SizedBox(width: 5),
                      const Icon(IconlyLight.discount, color: Colors.red),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.25,
                    child: ListView.builder(
                      itemCount: productsOnSale.length< 10?productsOnSale.length:10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return ChangeNotifierProvider.value(
                          value: null,
                          child:ChangeNotifierProvider.value(
                              value: productsOnSale[index],
                              child: const OnSaleWidget()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // "Our Products" Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Our products',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  TextButton(
                    onPressed: () {
                      GlobalMethods.nevigateTo(
                          ctx: context, routeName: FeedsScreen.routeName);
                    },
                    child: TextWidget(
                      text: 'Browse all',
                      maxLines: 1,
                      color: Colors.blue,
                      textSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            // Product GridView
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              childAspectRatio: size.width / (size.height * 0.61),
              children: List.generate(
                  allProducts.length < 4
                      ? allProducts.length
                      : 4, (index) {
                return ChangeNotifierProvider.value(
                      value: allProducts[index],
                      child: FeedsWidget(

                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
