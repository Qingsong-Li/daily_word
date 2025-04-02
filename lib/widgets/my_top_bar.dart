import 'package:flutter/material.dart';
import '../datas/user.dart';

class MyTopBar extends StatelessWidget {
  final String title;
  final IconData? leading;
  const MyTopBar({super.key, required this.title, required this.leading});

  @override
  Widget build(BuildContext context) {
    _alertDialog() async {
      var result = await showDialog(
          barrierDismissible: true,
          //表示点击灰色背景的时候是否消失弹出框
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color.fromRGBO(134, 177, 186, 0.8),
              title: const Text(
                "提示信息",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "AlimamaShuHeiTi-Bold",
                    fontSize: 25,
                    color: Color.fromRGBO(235, 230, 192, 0.8)),
              ),
              content: const Text(
                "你确定要退出登录吗?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "AlimamaShuHeiTi-Bold",
                    fontSize: 20,
                    color: Color.fromRGBO(235, 230, 192, 0.8)),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 85),
                  child: TextButton(
                    child: const Text(
                      "取消",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "AlimamaShuHeiTi-Bold",
                          fontSize: 16,
                          color: Color.fromRGBO(235, 230, 192, 0.8)),
                    ),
                    onPressed: () {
                      print("取消");
                      Navigator.pop(context, 'Cancle');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: TextButton(
                    child: const Text(
                      "确定",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "AlimamaShuHeiTi-Bold",
                          fontSize: 16,
                          color: Color.fromRGBO(235, 230, 192, 0.8)),
                    ),
                    onPressed: () {
                      print("确定");
                      User.logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/startpage', (route) => false);
                    },
                  ),
                )
              ],
            );
          });
      print(result);
    }

    return SizedBox(
      width: 393,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text(
              title,
              style: const TextStyle(
                  fontFamily: 'AlimamaShuHeiTi-Bold', fontSize: 32),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: IconButton(
              onPressed: () {
                _alertDialog();
              },
              icon: Icon(leading),
              iconSize: 42,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
