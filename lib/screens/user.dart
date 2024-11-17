import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocer/screens/viewed_recently/viewed_recently.dart';
import 'package:go_grocer/screens/wishlist/wishlist_screen.dart';
import 'package:go_grocer/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import '../widgets/text_widgets.dart';
import 'orders/orders_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
  TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add Logo at the top
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png', // Update the path to your logo
                        height: size.width * 0.12,
                        width: size.height * 1,
                        alignment: Alignment.topCenter,// You can adjust the size as needed
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Hi,  ',
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'MyName',
                            style: TextStyle(
                              color: color,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {}),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: 'email@email.com',
                    color: color,
                    textSize: 18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTile(
                    title: 'Address2',
                    subtitle: 'My subtitle',
                    icon: IconlyBold.profile,
                    color: color,
                    onPressed: () async {
                      await _showAddressDialog();
                    },
                  ),
                  _listTile(
                    title: 'Orders',
                    icon: IconlyBold.bag,
                    color: color,
                    onPressed: () {
                      GlobalMethods.nevigateTo(
                          ctx: context, routeName: OrdersScreen.routeName);
                    },
                  ),
                  _listTile(
                    title: 'Wishlist',
                    icon: IconlyBold.heart,
                    color: color,
                    onPressed: () {
                      GlobalMethods.nevigateTo(
                          ctx: context, routeName: WishlistScreen.routeName);
                    },
                  ),
                  _listTile(
                    title: 'Viewed',
                    icon: IconlyBold.show,
                    color: color,
                    onPressed: () {
                      GlobalMethods.nevigateTo(
                          ctx: context, routeName: ViewedRecentlyScreen.routeName);
                    },
                  ),
                  _listTile(
                    title: 'Forget Password',
                    icon: IconlyBold.unlock,
                    color: color,
                    onPressed: () {},
                  ),
                  SwitchListTile(
                    title: TextWidget(
                      text: themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                      color: color,
                      textSize: 18,
                    ),
                    secondary: Icon(
                      themeState.getDarkTheme
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onChanged: (bool value) {
                      setState(() {
                        themeState.setDarkTheme = value;
                      });
                    },
                    value: themeState.getDarkTheme,
                  ),
                  _listTile(
                    title: 'Logout',
                    icon: IconlyBold.logout,
                    color: color,
                    onPressed: () {
                      GlobalMethods.warningDialog(
                          title: 'Sign out',
                          subtitle: 'Do you wanna sign out?',
                          fct: () {},
                          context: context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              controller: _addressTextController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: "Your address"),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Update'),
              ),
            ],
          );
        });
  }

  Widget _listTile({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
      ),
      subtitle: TextWidget(
        text: subtitle ?? "",
        color: color,
        textSize: 18,
      ),
      leading: Icon(
        icon,
        color: color,
      ),
      trailing: Icon(
        IconlyLight.arrowRight2,
        color: color,
      ),
      onTap: () {
        onPressed();
      },
    );
  }
}
