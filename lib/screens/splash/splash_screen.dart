import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:managment/src/widgets/bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    goToHome();
  }

  void goToHome() => Timer(
        Duration(seconds: 2),
        () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => BottomBar(),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'WELCOME',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
