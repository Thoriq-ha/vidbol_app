import 'package:flutter/material.dart';
import 'package:vidbol_app/const.dart';

Widget buildAccountPageTabWidget() {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img/logo_vidbol.png'),
          Text(
            'Vidbol App is an application that is used to stream football highlights around the world. The matches shown are worldwide matches so it is suitable for football lovers around the world. For those who cant watch the match, they can view the replay on this app.',
            textAlign: TextAlign.justify,
            style: TextStyle(color: mColorOren),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Made by Thoriq_ha',
            style: TextStyle(color: mColorOren),
          )
        ],
      ),
    ),
  );
}
