import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monami/core/constant/routes.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {

    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 5);
    return new Timer(duration, loginRoute);
  }

  loginRoute() {
        Get.offNamed(AppRoutes.chesirLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white),
          ),
          Center(
            child: Container( 
                child: Image.asset('images/monami.png', width: 200,)),
          )
        ],
      ),
    );
  }
}
