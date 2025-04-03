
import 'package:flutter/material.dart';
import '../xi_yu/xi_yu_page.dart';
import '../yue_yu/yue_yu_page.dart';
import '../cang_yu/cang_yu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = const [
    XiYuPage(),
    YueYuPage(arguments: {}),
    CangYuPage(
      arguments: {},
    ),
  ];
  late int _currentPage;
  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    // / Initialize cache with null values
  }

  Widget _buildCangyuPage() {
    return const CangYuPage(arguments: {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: _currentPage,
          children: [
            _pages[0],
            // _pages[1],
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
                setState(() {
                  _currentPage = value;
                });
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
                BottomNavigationBarItem(
                    icon: Icon(
                      IconData(
                        0xe615,
                        fontFamily: "iconfont",
                      ),
                    ),
                    label: '')
              ],
            )));
  }
}
