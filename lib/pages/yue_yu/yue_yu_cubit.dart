import 'package:dailyword/datas/word.dart';
import 'package:dailyword/pages/yue_yu/yue_yu_state.dart';
import 'package:dailyword/tools/data_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YueYuCubit extends Cubit<YueYuState> {
  YueYuCubit() : super(YueYuState());
  late final FocusNode focusNode;
  //控制搜索框的消失
  late final AnimationController _controller1;
  late final Animation<Offset> offsetAnimation1;
  late final Animation<double> fadeAnimation1;

// 控制结果的显示
  late final AnimationController _controller2;
  late final Animation<Offset> offsetAnimation2;
  late final Animation<double> fadeAnimation2;

  final DatabaseHelper dbHelper = DatabaseHelper();

  initFocusNode() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      emit(state.copy(isFocused: focusNode.hasFocus));
    });
  }

  disposeFoucusNode() {
    focusNode.dispose();
  }

  initAnimation(TickerProvider tickerProvider) {
    // 设置搜索框消失的具体动画效果
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: tickerProvider,
    );
    offsetAnimation1 = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeInOut,
    ));
    fadeAnimation1 = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeInOut,
    ));

// 设置结果显示的具体效果
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: tickerProvider,
    );
    offsetAnimation2 = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInOut,
    ));
    fadeAnimation2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInOut,
    ));

    // 当搜索框彻底消失后启动结果的动画
    _controller1.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        // 上滑后并且搜索框彻底消失
        List<Word> results = await _search();
        emit(state.copy(showResult: true, results: results));
        _controller2.forward();
      }
    });
  }

  disposeAnimation() {
    _controller1.dispose();
    _controller2.dispose();
  }

  Future<List<Word>> _search() async {
    List resultWord = await dbHelper.searchChengyu(state.searchText);

    return resultWord.map((e) {
      return Word.fromJson(e);
    }).toList();
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.primaryDelta! < -10 &&
        !state.isFocused &&
        state.searchText.isNotEmpty) {
      _controller1.forward();
    }
  }

  void reset() {
    _controller1.reset();
    _controller2.reset();

    emit(state.copy(
        isFocused: false, showResult: false, searchText: "", results: []));
  }
}
