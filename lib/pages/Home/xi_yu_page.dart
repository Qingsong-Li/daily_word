import 'package:dailyword/widgets/base_page.dart';
import 'package:flutter/material.dart';
import '../../widgets/my_top_bar.dart';
import '../../widgets/word_card.dart';
import '../../datas/word.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../tools/keep_alive_wrapper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

String token = "";

class XiYuPage extends StatefulWidget {
  const XiYuPage({super.key});

  @override
  State<XiYuPage> createState() => _XiYuPageState();
}

class _XiYuPageState extends State<XiYuPage> {
  Word word = Word.empty();
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    // await getToken();
    // Word tempWord = await Word.getRandom(token);
    // while (tempWord.name.length > 5) {
    //   tempWord = await Word.getRandom(token);
    // }
    // setState(() {
    //   word = tempWord;
    // });
  }

  void refreshData() async {
    Word tempWord = await Word.getRandom(token);
    while (tempWord.name.length > 5) {
      tempWord = await Word.getRandom(token);
    }
    setState(() {
      word = tempWord;
    });
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold(
      body: BasePage(
          child: Column(
        children: [
          SizedBox(
            height: 75.h,
          ),
          const MyTopBar(
              title: "习语",
              leading: IconData(0xe649,
                  fontFamily: "iconfont", matchTextDirection: true)),
          word.name == ""
              ? const SizedBox()
              : GestureDetector(
                  onLongPress: () {
                    refreshData();
                  },
                  child: SizedBox(
                    height: 570.h,
                    child: WordCard(
                      word: word,
                      token: token,
                    ),
                  ),
                ),
          const SizedBox(
            width: double.infinity,
            child: Text(
              "长按卡片刷新",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "AlimamaShuHeiTi-Bold",
                  fontSize: 16,
                  color: Color.fromRGBO(235, 230, 192, 0.8)),
            ),
          )
        ],
      )),
    ));
  }
}
