import 'package:company/UI/component/component.dart';
import 'package:company/UI/pages/login_screen.dart';
import 'package:company/UI/pages/showservice_screen.dart';

import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  double top;
  double bottom;
  Animation animation;
  AnimationController imageController;
  @override
  void initState() {
    imageController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween(begin: 0.0, end: 140.0).animate(imageController)
      ..addStatusListener((status) {
        // print(status);
        if (status == AnimationStatus.completed) {
          imageController.dispose();
          // print('completed');
        }
      })
      ..addListener(() {
        // print('${imageController.value}');
        setState(() {
          bottom = animation.value;
          top = animation.value;
        });
      });
    imageController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              AnimatedPositioned(
                  curve: Curves.linearToEaseOut,
                  top: top,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/file.png'))),
                    ),
                  ),
                  duration: Duration(seconds: 1)),
              AnimatedPositioned(
                curve: Curves.linear,
                child: Container(
                  child: Column(
                    children: [
                      defaultButton(
                        text: 'sing in ',
                        function: () {
                          navigateTo(context, LogInScreen());
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultButton(
                          text: 'show service',
                          function: () {
                            navigateTo(context, ShowServiceScreen());
                          }),
                    ],
                  ),
                ),
                bottom: bottom,
                duration: Duration(seconds: 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
