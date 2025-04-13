import 'package:dailyword/pages/xi_yu/xi_yu_cubit.dart';
import 'package:dailyword/pages/yue_yu/yue_yu_cubit.dart';
import 'package:dailyword/tools/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';
import '../xi_yu/xi_yu_page.dart';
import '../yue_yu/yue_yu_page.dart';
import '../cang_yu/cang_yu_page.dart';

const int XiYuPageIndex = 0;
const int YueYuPageIndex = 1;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = const [
    KeepAliveWrapper(child: XiYuPage()),
    KeepAliveWrapper(child: YueYuPage()),
  ];
  late int _currentPage;
  late final PageController _pageController;
  late final XiYuCubit _xiyuCubit;
  late final YueYuCubit _yueyuCubit;


  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _pageController = PageController();
    _xiyuCubit = XiYuCubit();
    _yueyuCubit = YueYuCubit();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
            switch(index){
              case XiYuPageIndex:
              _xiyuCubit.checkUpdate();
              break;
              case YueYuPageIndex:
              _yueyuCubit.checkUpdate();
              break;

            }
          },
          children: [
            _pages[0],
            _pages[1],
            // _buildCangyuPage()
          ],
        ),
        bottomNavigationBar: Theme(
            data: ThemeData(
              brightness: Brightness.light,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: _currentPage,
              selectedIconTheme: const IconThemeData(
                  size: 36, color: Color.fromRGBO(199, 229, 235, 1)),
              unselectedIconTheme:
                  const IconThemeData(size: 36, color: Colors.black),
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              onTap: (value) {
                _pageController.jumpToPage(value);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      IconData(0xe625, fontFamily: "iconfont"),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      IconData(0xe61d, fontFamily: "iconfont"),
                    ),
                    label: ''),
                // BottomNavigationBarItem(
                //     icon: Icon(
                //       IconData(0xe61e, fontFamily: "iconfont"),
                //     ),
                //     label: ''),
                // BottomNavigationBarItem(
                //     icon: Icon(
                //       IconData(
                //         0xe615,
                //         fontFamily: "iconfont",
                //       ),
                //     ),
                //     label: '')
              ],
            )));
  }
}
