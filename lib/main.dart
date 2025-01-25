import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_grocer/provider/dark_theme_provider.dart';
import 'package:go_grocer/providers/cart_provider.dart';
import 'package:go_grocer/providers/product_provider.dart';
import 'package:go_grocer/providers/viewed_prod_provider.dart';
import 'package:go_grocer/providers/wishlist_provider.dart';
import 'package:go_grocer/screens/viewed_recently/viewed_recently.dart';
import 'package:provider/provider.dart';
import 'package:go_grocer/screens/btm_bar.dart'; // Set to your desired initial screen
import 'consts/theme_data.dart';
import 'inner_screens/cat_screen.dart';
import 'inner_screens/feeds_screen.dart';
import 'inner_screens/on_sale_screen.dart';
import 'inner_screens/product_details.dart';
import 'screens/auth/forget_pass.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/orders/orders_screen.dart';
import 'screens/wishlist/wishlist_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme = await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }
final Future<FirebaseApp>_firebaseInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if(snapshot.hasError){
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('An error occured!'),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => themeChangeProvider),
            ChangeNotifierProvider(create: (_) => ProductsProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => WishlistProvider()),
            ChangeNotifierProvider(create: (_) => ViewedProdProvider()),
            // ChangeNotifierProvider(create: (_) => OrdersProvider()),
          ],
          child: Consumer<DarkThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: Styles.themeData(themeProvider.getDarkTheme, context),
                home: const BottomBarScreen(), // Set your initial screen here
                routes: {
                  OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
                  FeedsScreen.routeName: (ctx) => const FeedsScreen(),
                  ProductDetails.routeName: (ctx) => const ProductDetails(),
                  WishlistScreen.routeName: (ctx) => const WishlistScreen(),
                  OrdersScreen.routeName: (ctx) => const OrdersScreen(),
                  ViewedRecentlyScreen.routeName: (ctx) => const ViewedRecentlyScreen(),
                  ResisterScreen.routeName: (ctx) => const ResisterScreen(),
                  LoginScreen.routeName: (ctx) => const LoginScreen(),
                  ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
                  BottomBarScreen.routeName: (ctx) => const BottomBarScreen(),
                  CategoryScreen.routeName: (ctx) => const CategoryScreen(),
                },
              );
            },
          ),
        );
      }
    );
  }
}
