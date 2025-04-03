import 'package:flutter/material.dart';
import '../datas/word.dart';
import 'my_list_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WordCard extends StatefulWidget {
  final Word word;
  const WordCard({super.key, required this.word});

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: 333.w,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(28), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(2, 2),
          spreadRadius: -1.0,
          blurRadius: 4,
        )
      ]),
      child: Card(
          color: const Color.fromRGBO(222, 218, 182, 1),
          shape: RoundedRectangleBorder(
              // side: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(28)),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70.w,
                  ),
                  SizedBox(
                    width: 150.w,
                    child: Text(widget.word.name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily:
                                "Alibaba_PuHuiTi_2.0_65_Medium_65_Medium",
                            fontSize: 30,
                            color: Color.fromRGBO(66, 116, 128, 1))),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  IconButton(
                      onPressed: () {
            
                      },
                      icon: Icon(
                        IconData(widget.word.collected == 1 ? 0xeca6 : 0xe65e,
                            fontFamily: 'iconfont'),
                        size: 30.w,
                      ))
                ],
              ),
              SizedBox(
                height: 14.w,
              ),
              MyListTile(
                  title: getTitle(widget.word.sound),
                  text: getBody(widget.word.sound)),
              MyListTile(
                  title: getTitle(widget.word.explanation),
                  text: getBody(widget.word.explanation)),
              MyListTile(
                  title: getTitle(widget.word.provenance),
                  text: getBody(widget.word.provenance)),
              MyListTile(
                  title: getTitle(widget.word.emotionalColor),
                  text: getBody(widget.word.emotionalColor)),
              MyListTile(
                  title: getTitle(widget.word.structure),
                  text: getBody(widget.word.structure)),
              MyListTile(
                  title: getTitle(widget.word.synonyms),
                  text: getBody(widget.word.synonyms)),
              MyListTile(
                  title: getTitle(widget.word.antonym),
                  text: getBody(widget.word.antonym)),
              MyListTile(
                  title: getTitle(widget.word.example),
                  text: getBody(widget.word.example)),
            ],
          )),
    );
  }

  String getTitle(String input) {
    if (input == "") {
      return "";
    }
    int colonIndex = input.indexOf('：');
    if (colonIndex == -1) {
      throw ArgumentError('The input string does not contain a colon.');
    }
    return input.substring(0, colonIndex);
  }

  String getBody(String input) {
    if (input == "") {
      return "";
    }
    int colonIndex = input.indexOf('：');
    if (colonIndex == -1) {
      throw ArgumentError('The input string does not contain a colon.');
    }
    return colonIndex + 1 < input.length ? input.substring(colonIndex + 1) : '';
  }

  // void shouCang(Word word, String token) async {
  //   if (word.collected == false) {
  //     bool result = await Word.shouCang(word, token);
  //     setState(() {
  //       if (result == true) {
  //         word.collected = 1;
  //       }
  //     });
  //   } else {
  //     bool result = await Word.cancelShouCang(word, token);
  //     setState(() {
  //       if (result == true) {
  //         word.collected = 0;
  //       }
  //     });
  //   }
  // }
}

// class _WordCardState extends State<WordCard> {
//   double touchx = 0;
//   double touchy = 0;
//   bool startTransform = true;
//   @override
//   Widget build(BuildContext context) {
//     return Transform(
//       transform: Matrix4.identity()
//         ..setEntry(3, 2, 0.001)
//         ..rotateX(startTransform ? touchy : 0.0)
//         ..rotateY(startTransform ? touchx : 0.0),
//       alignment: FractionalOffset.center,
//       child: GestureDetector(
//           onTapUp: (_) => setState(() {
//                 startTransform = false;
//               }),
//           onPanCancel: () => setState(() => startTransform = false),
//           onPanEnd: (_) => setState(() {
//                 startTransform = false;
//               }),
//           onPanUpdate: (details) {
//             setState(() => startTransform = true);

//             ///y轴限制范围
//             if (details.localPosition.dx < 333 * 0.55 &&
//                 details.localPosition.dx > 333 * 0.3) {
//               touchx = (333 / 2 - details.localPosition.dx) / 100;
//             }

//             ///x轴限制范围
//             if (details.localPosition.dy > 530 * 0.4 &&
//                 details.localPosition.dy < 530 * 0.6) {
//               touchy = (details.localPosition.dy - 530 / 2) / 100;
//             }
//           },
//           child: Container(
//             margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
//             height: 530,
//             width: 333,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(28),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.4),
//                     offset: const Offset(4, 4),
//                     spreadRadius: 0.0,
//                     blurRadius: 4.0,
//                   )
//                 ]),
//             child: Card(
//                 color: const Color.fromRGBO(222, 218, 182, 1),
//                 shape: RoundedRectangleBorder(
//                     // side: const BorderSide(color: Colors.black, width: 1.0),
//                     borderRadius: BorderRadius.circular(28)),
//                 child: Transform(
//                   transform: Matrix4.identity()
//                     ..translate(startTransform ? touchx * 100 - 2 : 0.0,
//                         startTransform ? touchy * 100 - 2 : 0.0, 0.0),
//                   child: ListView(
//                     physics: const NeverScrollableScrollPhysics(),
//                     padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SizedBox(
//                             width: 70,
//                           ),
//                           Text(widget.word.getWord,
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(
//                                   fontFamily:
//                                       "Alibaba_PuHuiTi_2.0_65_Medium_65_Medium",
//                                   fontSize: 30,
//                                   color: Color.fromRGBO(66, 116, 128, 1))),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   shouCang(widget.word);
//                                 });
//                               },
//                               icon: Icon(
//                                 IconData(
//                                     widget.word.getShouCang ? 0xe8c6 : 0xf0114,
//                                     fontFamily: 'iconfont'),
//                                 size: 30,
//                               ))
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 14,
//                       ),
//                       MyListTile(
//                           title: "简介", text: widget.word.getIntroduction),
//                       MyListTile(title: "来源", text: widget.word.getOrigin),
//                       MyListTile(title: "示例", text: widget.word.getSymbol),
//                       MyListTile(title: "同义词", text: widget.word.getTongYi),
//                       MyListTile(title: "反义词", text: widget.word.getFanYi),
//                     ],
//                   ),
//                 )),
//           )),
//     );
//   }

//   void shouCang(Word word) {
//     print(word.getShouCang ? "取消收藏${word.getWord}" : "收藏了${word.getWord}");
//     word.shouCang = !word.shouCang;
//   }
// }
