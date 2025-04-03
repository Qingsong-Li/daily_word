import 'package:dailyword/datas/word.dart';

class XiYuState {
  final Word word;
  XiYuState({required this.word});

  XiYuState copy({Word? word}) {
    return XiYuState(word: word ?? this.word);
  }
}
