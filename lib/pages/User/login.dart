import 'package:dailyword/datas/user.dart';
import 'package:dailyword/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isFoucs = false;
  late SharedPreferences prefs;

  String userName = "username";
  String password = "";

  void login() async {
    prefs.setString("token", "");

    if (userName == "" || password == "") {
      alter('账号或密码不能为空');
    } else {
      bool result = await User.login(userName, password);
      if (result == true) {
        prefs.setBool("isLogined", true);

        Navigator.pushNamedAndRemoveUntil(
            context, '/homepage', (route) => false);
      } else {
        alter("密码错误");
      }
    }
  }

  void alter(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromRGBO(66, 116, 128, 0.8),
        textColor: const Color.fromRGBO(222, 218, 182, 1),
        fontSize: 18.0);
    // Fluttertoast.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePage(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
            ),
            const Icon(
              IconData(0xe649, fontFamily: "iconfont"),
              size: 150,
            ),
            Text(
              userName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  height: 0.9,
                  fontFamily: "AlimamaShuHeiTi-Bold",
                  fontSize: 30),
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextField(
              icon: const Icon(
                IconData(0xe601, fontFamily: "iconfont"),
                size: 24,
              ),
              hintText: userName,
              onChanged: (value) {
                setState(() {
                  userName = value == "" ? "username" : value;
                });
              },
              obscureText: false,
            ),
            const SizedBox(
              height: 40,
            ),
            MyTextField(
                obscureText: true,
                icon: const Icon(
                  IconData(0xe672, fontFamily: "iconfont"),
                  size: 24,
                ),
                hintText: "password",
                onChanged: (value) {
                  // print(value);
                  password = value;
                }),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 30,
              child: Text(
                "账号不存在将自动注册",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "AlimamaShuHeiTi-Bold",
                    fontSize: 16,
                    color: Color.fromRGBO(235, 232, 192, 1)),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 52,
                ),
                MyTextButton(
                    text: "<-返回",
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                const Spacer(),
                MyTextButton(text: "登陆->", onPressed: login),
                const SizedBox(
                  width: 52,
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

class MyTextField extends StatefulWidget {
  final bool obscureText;
  final Icon icon;
  final String hintText;
  final void Function(String value)? onChanged;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.onChanged,
      required this.icon,
      required this.obscureText});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: 238,
      child: TextField(
        obscureText: widget.obscureText,
        style: TextStyle(
            fontFamily: "AlimamaShuHeiTi-Bold",
            fontSize: 24,
            color: Colors.black.withOpacity(0.57)),
        onChanged: widget.onChanged,
        cursorColor: Colors.black,
        cursorHeight: 30,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, right: 20),
              child: widget.icon,
            ),
            fillColor: const Color.fromRGBO(218, 238, 242, 0.3),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontFamily: "AlimamaShuHeiTi-Bold",
                fontSize: 24,
                color: Colors.black.withOpacity(0.57))),
      ),
    );
  }
}

class MyTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const MyTextButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: "AlimamaShuHeiTi-Bold",
            fontSize: 30,
            color: Color.fromRGBO(235, 232, 192, 1)),
      ),
    );
  }
}
