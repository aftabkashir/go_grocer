import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocer/screens/auth/login.dart';
import 'package:go_grocer/screens/btm_bar.dart';
import 'package:go_grocer/services/global_methods.dart';
import '../../consts/constss.dart';
import '../../consts/firebase_consts.dart';
import '../../services/utils.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/text_widgets.dart';
import '../loading_manager.dart';
import 'forget_pass.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResisterScreen extends StatefulWidget {
  static const routeName = '/ResisterScreen';
  const ResisterScreen({super.key});

  @override
  State<ResisterScreen> createState() => _ResisterScreenState();
}

class _ResisterScreenState extends State<ResisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();

  bool _obscureText = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _addressTextController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();
      // Add your registration logic here
      try {
        await authInstance.createUserWithEmailAndPassword(
          email: _emailTextController.text.toLowerCase().trim(),
          password: _passTextController.text.trim(),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BottomBarScreen(),
          ),
        );
        print('Succefully Regestered');
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '{$error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = Utils(context).color;
    Size size = utils.getScreenSize;

    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: <Widget>[
            Swiper(
              duration: 800,
              autoplayDelay: 6000,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Constss.authImagesPaths[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: Constss.authImagesPaths.length,
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(height: 60.0),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.canPop(context)
                        ? Navigator.pop(context)
                        : null,
                    child: const Icon(
                      IconlyLight.arrowLeft2,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Add the logo here
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png', // Update the path as needed
                      height: size.width * 0.14,
                      width: size.width * 0.45, // Path to your logo
                      fit: BoxFit.contain,
                      alignment: Alignment.center, // Adjust the width as needed
                    ),
                  ),
                  const SizedBox(height: 20.0), // Space between logo and text
                  // Center the welcome text and the sign-up prompt
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: 'Welcome',
                          color: Colors.white,
                          textSize: 30,
                          isTitle: true,
                        ),
                        const SizedBox(height: 8),
                        TextWidget(
                          text: "Sign up to continue!",
                          color: Colors.white,
                          textSize: 18,
                          isTitle: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_emailFocusNode),
                          keyboardType: TextInputType.name,
                          controller: _fullNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This Field is missing";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Full name',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailTextController,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains("@")) {
                              return "Please enter a valid Email address";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Password
                        TextFormField(
                          focusNode: _passFocusNode,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passTextController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return "Please enter a valid password";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_addressFocusNode),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          focusNode: _addressFocusNode,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _submitFormOnRegister,
                          controller: _addressTextController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return "Please enter a valid address";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          decoration: const InputDecoration(
                            hintText: ' Address ',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          ForgetPasswordScreen.routeName,
                        );
                      },
                      child: const Text(
                        'Forget password?',
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  AuthButton(
                    buttonText: 'Sign up',
                    fct: () {
                      _submitFormOnRegister();
                    },
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                        text: 'Already a user?',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Log in',
                            style: const TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName);
                              },
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
