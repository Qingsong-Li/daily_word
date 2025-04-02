import 'package:dailyword/widgets/base_page.dart';
import 'package:flutter/material.dart';
import '../../widgets/my_top_bar.dart';
import '../../widgets/word_card.dart';
import '../../datas/word.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String token = "";

late bool isSearching;
late bool isSubmit;
late bool isNull; //文本框是否为空
List<WordCard> result = [];
String searchText = "";

class YueYuPage extends StatefulWidget {
  final Map arguments;
  const YueYuPage({super.key, required this.arguments});

  @override
  State<YueYuPage> createState() => _YueYuPageState();
}

class _YueYuPageState extends State<YueYuPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        resizeToAvoidBottomInset: false,
        body: BasePage(
            child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: SearchCard(),
        )));
  }
}

// 搜索按钮
class SearchButton extends StatefulWidget {
  final Function()? onPressed;
  const SearchButton({super.key, required this.onPressed});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: widget.onPressed,
        icon: Icon(
          shadows: [
            Shadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
          const IconData(0xe604, fontFamily: "iconfont"),
          size: 175,
          color: const Color.fromRGBO(134, 177, 186, 1),
        ));
  }
}

//搜索框
class AutoFocusTextField extends StatefulWidget {
  final Function(String text)? writing;
  const AutoFocusTextField({super.key, required this.writing});

  @override
  // ignore: library_private_types_in_public_api
  _AutoFocusTextFieldState createState() => _AutoFocusTextFieldState();
}

class _AutoFocusTextFieldState extends State<AutoFocusTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 91.w,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextField(
        onChanged: (value) {
          widget.writing!(value);
        },
        textAlign: TextAlign.center,
        cursorWidth: 4,
        cursorColor: Colors.black,
        focusNode: _focusNode,
        style: const TextStyle(
            fontFamily: "AlimamaShuHeiTi-Bold",
            fontSize: 60,
            color: Color.fromRGBO(66, 116, 128, 1)),
        decoration: const InputDecoration.collapsed(hintText: null),
      ),
    );
  }
}

//背景版
class SearchCard extends StatefulWidget {
  const SearchCard({super.key});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> with TickerProviderStateMixin {
  //控制搜索框的消失
  late AnimationController _controller1;
  late Animation<Offset> _offsetAnimation1;
  late Animation<double> _fadeAnimation1;

// 控制结果的显示
  late AnimationController _controller2;
  late Animation<Offset> _offsetAnimation2;
  late Animation<double> _fadeAnimation2;
// ignore: non_constant_identifier_names
  void Search() async {
    print('Card上滑手势');
    isSubmit = true;
    setState(() {
      result = [];
    });
    List<Word> resultWord = await Word.searchByWord(searchText, token);

    setState(() {
      for (Word item in resultWord) {
        if (item.name.length <= 5) {
          result.add(WordCard(word: item, token: token));
        }
      }
    });
    print(result);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSearching = false;
    isSubmit = false;
    isNull = true;

// 设置搜索框消失的具体动画效果
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation1 = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeInOut,
    ));
    _fadeAnimation1 = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeInOut,
    ));

// 设置结果显示的具体效果
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _offsetAnimation2 = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInOut,
    ));
    _fadeAnimation2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInOut,
    ));

// 当搜索框彻底消失后启动结果的动画
    _controller1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 上滑后并且搜索框彻底消失
        setState(() {
          isSearching ? Search() : null;
        });
        _controller2.forward();
      }
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.primaryDelta! < 0 && isSearching && !isNull) {
      _controller1.forward();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white,
                Color.fromARGB(1000, 134, 177, 186),
                Color.fromARGB(1000, 134, 177, 186)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.2])),
      child: Column(
        children: [
          SizedBox(
            height: 75.h,
          ),
          const MyTopBar(
              title: "阅语",
              leading: IconData(0xe649,
                  fontFamily: "iconfont", matchTextDirection: true)),
          (isSearching && isSubmit == false && isNull == false)
              ? const Text(
                  "上滑查看结果",
                  style: TextStyle(
                      fontFamily: "AlimamaShuHeiTi-Bold",
                      fontSize: 16,
                      color: Color.fromRGBO(84, 107, 112, 1)),
                ) //上滑查看结果
              : SizedBox(height: isSubmit ? 0 : 0),
          isSubmit
              ? SlideTransition(
                  position: _offsetAnimation2,
                  child: FadeTransition(
                      opacity: _fadeAnimation2,
                      child: result.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              height: 570.h,
                              child: const Text(
                                "正在搜索中,请稍等...",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "AlimamaShuHeiTi-Bold",
                                    fontSize: 30,
                                    color: Color.fromRGBO(235, 230, 192, 0.8)),
                              ))
                          : ResultWords(wordList: result)),
                )
              : GestureDetector(
                  onVerticalDragUpdate: _onVerticalDragUpdate,
                  child: SlideTransition(
                    position: _offsetAnimation1,
                    child: FadeTransition(
                      opacity: _fadeAnimation1,
                      child: Container(
                        margin:
                            EdgeInsets.fromLTRB(0, isSearching ? 5 : 15, 0, 0),
                        height: 575.h,
                        width: 333.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(2, 2),
                                spreadRadius: -1.0,
                                blurRadius: 4,
                              )
                            ]),
                        child: Card(
                            margin: const EdgeInsets.all(0),
                            color: const Color.fromRGBO(222, 218, 182, 1),
                            shape: RoundedRectangleBorder(
                                // side: const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(28)),
                            child: Container(
                              height: 550.h,
                              width: 333.w,
                              alignment: Alignment.center,
                              child: !isSearching
                                  ? SearchButton(onPressed: () {
                                      setState(() {
                                        isSearching = !isSearching;
                                      });
                                    })
                                  : AutoFocusTextField(
                                      writing: (value) {
                                        setState(() {
                                          if (value == "") {
                                            isNull = true;
                                          } else {
                                            searchText = value;
                                            isNull = false;
                                          }
                                        });
                                      },
                                    ),
                            )),
                      ),
                    ),
                  ),
                ),
          const SizedBox(height: 0),
          isSearching
              ? GestureDetector(
                  onTap: isSearching
                      ? () {
                          setState(() {
                            isSearching = !isSearching;
                            isSubmit = false;
                            print("点击了空白处");
                            _controller1.reset();
                            _controller2.reset();
                            isNull = true;
                          });
                        }
                      : null,
                  child: SizedBox(
                    height: isSearching ? 70.h : 55.h,
                    width: double.infinity,
                    child: const Text(
                      "按任意空白处返回",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "AlimamaShuHeiTi-Bold",
                          fontSize: 16,
                          color: Color.fromRGBO(235, 230, 192, 0.8)),
                    ),
                  ),
                )
              : SizedBox(height: 50.h)
        ],
      ),
    );
  }
}

//搜索结果
class ResultWords extends StatefulWidget {
  final List<WordCard> wordList;
  const ResultWords({super.key, required this.wordList});

  @override
  State<ResultWords> createState() => _ResultWordsState();
}

class _ResultWordsState extends State<ResultWords> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 570.h,
      width: double.infinity,
      // margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: CarouselSlider.builder(
          itemCount: widget.wordList.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return widget.wordList[itemIndex];
          },
          options: CarouselOptions(
            height: 550.h,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            viewportFraction: 0.85,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
          )),
    );
  }
}
