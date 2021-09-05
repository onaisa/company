import 'package:company/UI/component/component.dart';
import 'package:company/UI/pages/intro_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      navigateAndFinish(context, IntroScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 70.0),
          child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/file.png'))),
          ),
        ),
      ),
    );
  }
}
