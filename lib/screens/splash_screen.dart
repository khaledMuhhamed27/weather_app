import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_modern/screens/weather_home.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Lottie.asset(
                'lib/assets/animation/Animation - 1719950492646.json',
                width: 800,
                height: 800,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  AutoSizeText(
                    "Weather Forecast ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    minFontSize: 20,
                    maxFontSize: 26,
                  ),
                  AutoSizeText("From Khaled ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      minFontSize: 20,
                      maxFontSize: 26),
                ],
              ),
            )
          ],
        ),
      ),
      nextScreen: WeatherHome(),
      duration: 3500,
      backgroundColor: Color(0xff676bd0),
      splashIconSize: 400,
    );
  }
}
