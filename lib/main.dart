import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vidbol_app/const.dart';
import 'package:vidbol_app/screens/login_screen.dart';
import 'package:vidbol_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
              debugShowCheckedModeBanner: false, home: SplashScreen());
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: appTitle,
            theme: ThemeData(
              primarySwatch: Colors.orange,
            ),
            home: LoginScreen(),
          );
        }
      },
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
