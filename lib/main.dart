import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'pages/splash_screen.dart';

void main() {
  runApp(LoginUiApp());
}

// ignore: must_be_immutable
class LoginUiApp extends StatelessWidget {
  Color _primaryColor = HexColor('#DC54FE');
  Color _hintColor = HexColor('#8A02AE');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      theme: ThemeData(
        primaryColor: _primaryColor,
        hintColor: _hintColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen(title: 'Flutter Login UI'),
    );
  }
}
