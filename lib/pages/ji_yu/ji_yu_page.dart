import 'package:dailyword/widgets/base_page.dart';
import 'package:flutter/material.dart';
import '../../widgets/my_top_bar.dart';

class JiYuPage extends StatefulWidget {
  const JiYuPage({super.key});

  @override
  State<JiYuPage> createState() => _JiYuPageState();
}

class _JiYuPageState extends State<JiYuPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BasePage(
          child: Column(
        children: [
          SizedBox(
            height: 75,
          ),
          MyTopBar(
              title: "记语",
              leading: IconData(0xe649,
                  fontFamily: "iconfont", matchTextDirection: true)),
        ],
      )),
    );
  }
}
