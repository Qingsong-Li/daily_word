import 'package:dailyword/widgets/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/my_top_bar.dart';
import '../../datas/word.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../widgets/word_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String token = "";

class CangYuPage extends StatefulWidget {
  final Map arguments;
  const CangYuPage({super.key, required this.arguments});

  @override
  State<CangYuPage> createState() => _CangYuPageState();
}

class _CangYuPageState extends State<CangYuPage> {
  List<Word> collectWordList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async {
    collectWordList = [];
    await getToken();
    List<Word> result = await Word.getCollectedWords(token);
    setState(() {
      collectWordList = result;
    });
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? "";
  }

// 取消收藏后返回收藏页面的刷新
  void refreshData1(int index) async {
    bool result =
        await Word.checkCollectdById(collectWordList[index].id, token);
    setState(() {
      if (result == false) {
        collectWordList.removeAt(index);
      }
    });
  }

  // 下拉刷新
  Future<void> refreshData2() async {
    // collectWordList = [];
    print("refreash");
    List<Word> result = await Word.getCollectedWords(token);
    setState(() {
      collectWordList = result;
      // print(collectWordList);
    });
  }

  bool isSelected = false;
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasePage(
          child: Column(
        children: [
          SizedBox(
            height: 75.h,
          ),
          const MyTopBar(
              title: "藏语",
              leading: IconData(0xe649,
                  fontFamily: "iconfont", matchTextDirection: true)),
          isSelected == true
              ? SizedBox(
                  height: 570.h,
                  child: WordCard(
                    word: collectWordList[selectIndex],
                    token: token,
                  ),
                )
              : SizedBox(
                  width: 345.45.w,
                  height: 590.h,
                  child: RefreshIndicator(
                      backgroundColor:
                          const Color.fromARGB(1000, 134, 177, 186),
                      color: const Color.fromRGBO(235, 230, 192, 1),
                      onRefresh: refreshData2,
                      child: ListView.builder(
                          padding: const EdgeInsets.only(top: 20),
                          itemCount: collectWordList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  print("点击了${index + 1}条收藏");
                                  isSelected = true;
                                  selectIndex = index;
                                });
                              },
                              child: SimpleCard(
                                  word: collectWordList[index].name, scale: 1),
                            );
                          }))),
          isSelected
              ? SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        refreshData1(selectIndex);
                        isSelected = false;
                      });
                    },
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
              : SizedBox(
                  height: 0.h,
                )
        ],
      )),
    );
  }
}

class ColloctPicker extends StatefulWidget {
  final List<Word> colloctList;
  const ColloctPicker({super.key, required this.colloctList});

  @override
  State<ColloctPicker> createState() => _ColloctPickerState();
}

class _ColloctPickerState extends State<ColloctPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 530,
      child: CupertinoPicker.builder(
        diameterRatio: 5,
        selectionOverlay: null,
        squeeze: 1,
        childCount: widget.colloctList.length,
        itemExtent: 106.05,
        onSelectedItemChanged: (value) {
          print("当前为${value + 1}个收藏");
        },
        itemBuilder: (context, index) {
          return SimpleCard(
            word: widget.colloctList[index].name,
            scale: 1,
          );
        },
      ),
    );
  }
}

class SimpleCard extends StatelessWidget {
  final double scale;
  final String word;
  const SimpleCard({
    super.key,
    required this.word,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      alignment: Alignment.center,
      width: 345.45,
      height: 106.05,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(222, 218, 182, 0.9),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Theme(
          data: ThemeData(
            brightness: Brightness.light,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Text(
            word,
            style: const TextStyle(
                letterSpacing: 15,
                fontFamily: "Alibaba_PuHuiTi_2.0_65_Medium_65_Medium",
                fontSize: 45,
                color: Color.fromRGBO(103, 150, 161, 1)),
          )),
    );
  }
}

class CollectWordsListView extends StatefulWidget {
  final List<Word> colloctList;
  const CollectWordsListView({super.key, required this.colloctList});

  @override
  State<CollectWordsListView> createState() => _CollectWordsListViewState();
}

class _CollectWordsListViewState extends State<CollectWordsListView> {
  ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 550,
      child: NotificationListener(
          onNotification: (ScrollNotification scrollNotification) {
            setState(() {
              _scrollOffset = scrollNotification.metrics.pixels;
            });
            return true;
          },
          child: CarouselSlider.builder(
              itemCount: widget.colloctList.length,
              itemBuilder: (context, index, pageViewIndex) {
                double scale =
                    1 - (_scrollOffset - (index - 2) * 106.5).abs() / 852;
                scale = scale.clamp(0.8, 1.0);
                return SimpleCard(
                  word: widget.colloctList[index].name,
                  scale: scale,
                );
              },
              options: CarouselOptions(
                scrollDirection: Axis.vertical,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                viewportFraction: 0.85,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              ))),
    );
  }
}
