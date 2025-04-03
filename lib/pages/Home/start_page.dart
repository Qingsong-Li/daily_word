import 'dart:async';

import 'package:dailyword/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    // prefs.setBool("isLogined", false);//便于显示功能，每次打开都把登录状态设置为否，
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePage(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            height: 290,
            width: 290,
            child: Image.asset(
              "assets/images/cover.png",
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
              onPressed: () {
                Navigator.pushNamed(
                    context,
                    '/homepage');
              },
              child: const Text(
                "进入->",
                style: TextStyle(
                    fontFamily: "AlimamaShuHeiTi-Bold",
                    fontSize: 30,
                    color: Color.fromRGBO(235, 232, 192, 1)),
              ),
            ),
          )
        ],
      )),
    );
  }
}
