import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../consts/constss.dart';
import '../inner_screens/feeds_screen.dart';
import '../inner_screens/on_sale_screen.dart';
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Logo at the top
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Image.asset(
                'assets/images/logo.png',
                height: 50, // Set the logo height
              ),
            ),
            const SizedBox(height: 10),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
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
                      borderSide: const BorderSide(color: Colors.greenAccent, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.greenAccent, width: 1),
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
            ),

            // Swiper and remaining content
            SizedBox(
              height: size.height * 0.33,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Constss.offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: Constss.offerImages.length,
                pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.white, activeColor: Colors.red)),
              ),
            ),
            const SizedBox(height: 6),
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
            const SizedBox(height: 6),

            // On Sale Section
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
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
                const SizedBox(width: 8),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.24,
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return ChangeNotifierProvider.value(
                              value: null,
                              child: const OnSaleWidget());
                        }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Categories Section (before "Our Products")
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  TextWidget(
                    text: 'Categories',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: catInfo.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(catInfo[index]['imgPath']),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          catInfo[index]['catText'],
                          style: TextStyle(color: color, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

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
              children: List.generate(14, (index) {
                return ChangeNotifierProvider.value(
                  value: null,
                  child: const FeedsWidget(),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
