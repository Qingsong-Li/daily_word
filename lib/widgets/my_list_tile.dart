import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String text;

  final TextStyle _titleStyle = const TextStyle(
      fontFamily: "Alibaba_PuHuiTi_2.0_65_Medium_65_Medium",
      fontSize: 20,
      color: Color.fromRGBO(66, 116, 128, 1));

  final TextStyle _textStyle = const TextStyle(
      fontFamily: "Alibaba_PuHuiTi_2.0_65_Medium_65_Medium",
      fontSize: 16,
      color: Colors.black);

  const MyListTile({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    if (text == ""){
      return const SizedBox(height: 0,);
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: _titleStyle,
          ),
          const SizedBox(
            height: 7,
          ),
             Text(
            text,
            style: _textStyle,
          ),
        ],
      ),
    );
  }
}
