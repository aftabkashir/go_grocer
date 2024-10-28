import 'package:flutter/material.dart';
import 'package:go_grocer/widgets/text_widgets.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                'assets/images/google.png',
                width: 40.0,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            TextWidget(
              text: 'Sign in with google',
              color: Colors.white,
              textSize: 18,
            ),

          ],
        ),
      ),
    );
  }
}
