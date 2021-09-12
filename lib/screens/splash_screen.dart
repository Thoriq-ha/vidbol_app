import 'package:flutter/material.dart';
import 'package:vidbol_app/const.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: lightMode
          ? mColorOren
          // ? const Color(0x00e1f5fe).withOpacity(1.0)
          : Color(0x00FC5404).withOpacity(1.0),
      body: Center(
          child: lightMode
              ? Container(
                  height: 150, child: Image.asset('assets/img/logo_vidbol.png'))
              : Image.asset('assets/img/logo_vidbol.png')),
    );
  }
}
