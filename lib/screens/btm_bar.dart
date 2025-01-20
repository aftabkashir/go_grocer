import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocer/screens/categories.dart';
import 'package:go_grocer/screens/home_screen.dart';
import 'package:go_grocer/screens/user.dart';
import 'package:provider/provider.dart';
import '../provider/dark_theme_provider.dart';
import '../widgets/text_widgets.dart';
import 'cart/cart_screen.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {
      'page': const HomeScreen(),
      'title': 'Home Screen',
    },
    {
      'page': const CategoriesScreen(),
      'title': 'Categories Screen',
    },
    {
      'page': const CartScreen(),
      'title': 'Cart Screen',
    },
    {
      'page': const UserScreen(),
      'title': 'User Screen',
    },
    {
      'page': const HomeScreen(),
      'title': 'Home Screen',
    },
  ];
  void _selectedpage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool isDark = themeState.getDarkTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_pages[_selectedIndex]['title']),
      // ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark ? Theme.of(context).cardColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        unselectedItemColor: isDark ? Colors.white70 : Colors.black87,
        selectedItemColor: isDark ? Colors.lightBlue.shade400 : Colors.black54,
        onTap: _selectedpage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? IconlyBold.category
                : IconlyLight.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                badgeColor: Colors.blue,
                borderRadius: BorderRadius.circular(8),
                elevation: 0,
              ),
              position: badges.BadgePosition.topEnd(
                  top: -7,
                  end: -7), // BadgePosition is updated to badges.BadgePosition
              badgeContent: FittedBox(
                child: TextWidget(
                  text: '1',
                  color: Colors.white,
                  textSize: 15,
                ),
              ),
              child: Icon(
                _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
              ),
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
            label: "User",
          ),
        ],
      ),
    );
  }
}
