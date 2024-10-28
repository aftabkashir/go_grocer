import 'package:flutter/material.dart';
import 'package:go_grocer/inner_screens/feeds_screen.dart';
import 'package:go_grocer/widgets/text_widgets.dart';

import '../services/global_methods.dart';
import '../services/utils.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {super.key,
      required this.imagepath,
      required this.title,
      required this.subtitle,
      required this.buttonText});

  final String imagepath, title, subtitle, buttonText;

  @override
  Widget build(BuildContext context) {
    final themestate = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              imagepath,
              width: double.infinity,
              height: size.height * 0.4,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Whoops!',
              style: TextStyle(
                color: Colors.red,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              text: title,
              color: Colors.cyan,
              textSize: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              text: subtitle,
              color: Colors.cyan,
              textSize: 20,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.8),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                //onPrimary:color,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              onPressed: () {
                GlobalMethods.nevigateTo(
                    ctx: context, routeName: FeedsScreen.routeName);
              },
              child: TextWidget(
                text: buttonText,
                color: themestate ? Colors.grey.shade300 : Colors.grey.shade800,
                textSize: 20,
                isTitle: true,
              ),
            )
          ],
        ),
      )),
    );
  }
}
