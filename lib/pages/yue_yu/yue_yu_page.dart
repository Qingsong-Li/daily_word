import 'package:carousel_slider/carousel_slider.dart';
import 'package:dailyword/pages/yue_yu/yue_yu_cubit.dart';
import 'package:dailyword/pages/yue_yu/yue_yu_state.dart';
import 'package:dailyword/widgets/base_page.dart';
import 'package:dailyword/widgets/my_top_bar.dart';
import 'package:dailyword/widgets/word_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YueYuPage extends StatefulWidget {
  const YueYuPage({super.key});

  @override
  State<YueYuPage> createState() => _YueYuPageState();
}

class _YueYuPageState extends State<YueYuPage> with TickerProviderStateMixin {
  final YueYuCubit _cubit = YueYuCubit();

  @override
  void initState() {
    super.initState();
    _cubit.initFocusNode();
    _cubit.initAnimation(this);
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.disposeFoucusNode();
    _cubit.disposeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        child: BlocBuilder<YueYuCubit, YueYuState>(
            bloc: _cubit,
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 75.h),
                    child: const MyTopBar(
                        title: "阅语",
                        leading: IconData(0xe649,
                            fontFamily: "iconfont", matchTextDirection: true)),
                  ),
                  Visibility(
                      visible: !state.isFocused && state.searchText.isNotEmpty && !state.showResult,
                      replacement: const SizedBox(
                        height: 20,
                      ),
                      child: const SizedBox(
                        height: 20,
                        child: Text(
                          "上滑查看结果",
                          style: TextStyle(
                              fontFamily: "AlimamaShuHeiTi-Bold",
                              fontSize: 16,
                              color: Color.fromRGBO(84, 107, 112, 1)),
                        ),
                      )),
                  Expanded(
                      child:
                          state.showResult ? _getResults() : _getSearchCard()),
                  Visibility(
                      visible: state.showResult,
                      replacement: const SizedBox(
                        height: 20,
                      ),
                      child: GestureDetector(
                        onTap: _cubit.reset,
                        child: const SizedBox(
                          height: 20,
                          child: Text(
                            "返回",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "AlimamaShuHeiTi-Bold",
                                fontSize: 16,
                                color: Color.fromRGBO(235, 230, 192, 0.8)),
                          ),
                        ),
                      ))
                ],
              );
            }));
  }

  Widget _getSearchCard() {
    return GestureDetector(
      onVerticalDragUpdate: _cubit.onVerticalDragUpdate,
      child: SlideTransition(
        position: _cubit.offsetAnimation1,
        child: FadeTransition(
          opacity: _cubit.fadeAnimation1,
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
                child: _getTextField(),
              )),
        ),
      ),
    );
  }

  Widget _getTextField() {
    return BlocBuilder<YueYuCubit, YueYuState>(
        bloc: _cubit,
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // 背景图层
              Visibility(
                  visible: !state.isFocused && state.searchText.isEmpty,
                  child: Positioned(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 2))
                        ],
                        const IconData(0xe604, fontFamily: "iconfont"),
                        size: 175,
                        color: const Color.fromRGBO(134, 177, 186, 1),
                      ),
                    ),
                  )),

              // 前景 TextField
              Container(
                height: 91.w,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  onChanged: (value) {
                    _cubit.emit(state.copy(searchText: value));
                  },
                  textAlign: TextAlign.center,
                  cursorWidth: 4,
                  cursorColor: Colors.black,
                  focusNode: _cubit.focusNode,
                  style: const TextStyle(
                      fontFamily: "AlimamaShuHeiTi-Bold",
                      fontSize: 60,
                      color: Color.fromRGBO(66, 116, 128, 1)),
                  decoration: const InputDecoration.collapsed(hintText: null),
                ),
              ),
            ],
          );
        });
  }

  Widget _getResults() {
    return BlocBuilder<YueYuCubit, YueYuState>(
        bloc: _cubit,
        builder: (context, state) {
          return Container(
            alignment: Alignment.center,
            // padding: const EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            child: CarouselSlider.builder(
                itemCount: state.results.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return WordCard(word: state.results[itemIndex]);
                },
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  height: double.infinity,
                  enlargeFactor: 0.3,
                  viewportFraction: 0.85,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                )),
          );
        });
  }
}
