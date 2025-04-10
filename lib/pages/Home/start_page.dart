import 'package:dailyword/widgets/base_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePage(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100,),
          SizedBox(
            height: 290,
            width: 290,
            child: Image.asset(
              "assets/images/cover.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 80,),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/homepage");
            },
            child: const Text(
              "进入->",
              style: TextStyle(
                  fontFamily: "AlimamaShuHeiTi-Bold",
                  fontSize: 30,
                  color: Color.fromRGBO(235, 232, 192, 1)),
            ),
          )
        ],
      )),
    );
  }
}
