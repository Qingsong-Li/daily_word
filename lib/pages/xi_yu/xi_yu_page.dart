import 'package:dailyword/pages/xi_yu/xi_yu_cubit.dart';
import 'package:dailyword/pages/xi_yu/xi_yu_state.dart';
import 'package:dailyword/tools/data_base_helper.dart';
import 'package:dailyword/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/my_top_bar.dart';
import '../../widgets/word_card.dart';
import '../../datas/word.dart';

import '../../tools/keep_alive_wrapper.dart';

String token = "";

class XiYuPage extends StatefulWidget {
  const XiYuPage({super.key});

  @override
  State<XiYuPage> createState() => _XiYuPageState();
}

class _XiYuPageState extends State<XiYuPage> {
  final XiYuCubit _cubit = XiYuCubit();

  @override
  void initState() {
    super.initState();
    _cubit.initWord();
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: BlocProvider(
      create: (_) => _cubit,
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
            Expanded(
                child: BlocBuilder<XiYuCubit, XiYuState>(
                    builder: (_, state) => GestureDetector(
                          onLongPress: () {
                            _cubit.refreshWord();
                          },
                          child: WordCard(word: state.word),
                        ))),
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
      ),
    ));
  }
}
