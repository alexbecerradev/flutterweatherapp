import 'package:flutter/material.dart';

class Constants {
  final backgroundColor = const Color.fromARGB(255, 0, 22, 27);
  final primaryColor = const Color.fromARGB(190, 5, 172, 147);
  final secundaryColor = const Color.fromARGB(207, 17, 81, 129);
  final tertiaryColor = const Color.fromARGB(183, 218, 205, 180);
  final blackColor = const Color(0xff1a1d26);

  final greyColor = const Color.fromARGB(255, 199, 200, 201);

  final Shader shader = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(207, 17, 81, 129),
      Color(0x00171f1e),
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final linearGradientBlue = const LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff6b9dfc), Color(0xff205cf1)],
      stops: [0.0, 1.0]);
  final linearGradientPurple = const LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff51087E), Color(0xff6C0BA9)],
      stops: [0.0, 1.0]);
}
