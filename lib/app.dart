import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:harambee/screens/home_screen.dart';
import 'package:harambee/utils/constants.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        backgroundColor: kWhite,
        splash: Image.asset('assets/logo.png', fit: BoxFit.contain),
        nextScreen: HomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 2000,
        splashIconSize: 200,
      ),
    );
  }
}