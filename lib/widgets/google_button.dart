import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_grocer/consts/firebase_consts.dart';
import 'package:go_grocer/widgets/text_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/btm_bar.dart';
import '../services/global_methods.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await authInstance.signInWithCredential(GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const BottomBarScreen(),
            ),
          );
        } on FirebaseException catch (error) {
          GlobalMethods.errorDialog(subtitle: '${error.message}', context: context);


        } catch (error) {
          GlobalMethods.errorDialog(subtitle: '$error', context: context);
        } finally {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors
          .transparent, // Transparent material to respect the container's rounded corners
      child: InkWell(
        onTap: () {
          // Add your onTap functionality
          _googleSignIn(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue, // Background color of the button
            borderRadius:
                BorderRadius.circular(25), // Rounded corners for the button
          ),
          padding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 15.0), // Padding for button
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the contents horizontally
            children: [
              // Container for circular Google logo background
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white, // White background for the circle
                  shape: BoxShape.circle, // Circular shape for the container
                ),
                padding: const EdgeInsets.all(
                    2.0), // Padding to make the circle size appropriate
                child: Image.asset(
                  'assets/images/google.png',
                  width: 25.0, // Adjust the image size
                ),
              ),
              const SizedBox(width: 10),
              // Text centered with the logo
              TextWidget(
                text: 'Sign in with Google',
                color: Colors.white,
                textSize: 20,
                isTitle: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
