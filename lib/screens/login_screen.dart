import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vidbol_app/const.dart';
import 'package:vidbol_app/screens/main_screen.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Duration get loginTime => Duration(milliseconds: 250);

  Future<String?> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: data.name, password: data.password)
          .then((value) => '');
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> _signInGoogle() async {
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    final GoogleSignInAuthentication authentication =
        await account!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);

    try {
      await _firebaseAuth.signInWithCredential(credential).then((value) => '');
    } on FirebaseAuthException catch (e) {
      return e.code;
    }

    return '';
  }

  Future<String?> _authSignUp(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: data.name, password: data.password)
          .then((value) => '');
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: 'assets/img/logo_vidbol.png',
      onLogin: _authUser,
      onSignup: _authSignUp,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainScreen(),
        ));
      },
      theme: LoginTheme(
        primaryColor: mColorOren,
        accentColor: mColorYellow,
        logoWidth: 40,
      ),
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: _signInGoogle,
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebookF,
          label: 'Facebook',
          callback: _signInGoogle,
        ),
      ],
      onRecoverPassword: _recoverPassword,
      hideForgotPasswordButton: true,
    );
  }
}
