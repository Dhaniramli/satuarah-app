import 'package:flutter/material.dart';

import '../theme.dart';

class SplachscreenView extends StatelessWidget {
  const SplachscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: primaryColor,
          child: Center(
            child: Image.asset(
              'assets/logo_satuarah.png',
              width: 134.0,
              height: 208.29,
            ),
          ),
        ),
      ),
    );
  }
}
