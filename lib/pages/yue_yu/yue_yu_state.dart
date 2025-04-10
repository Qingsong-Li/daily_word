import 'package:dailyword/datas/word.dart';

class YueYuState {
  final bool isFocused;
  final bool showResult;
  final String searchText;
  final List<Word> results;

  YueYuState(
      {this.isFocused = false,
      this.showResult = false,
      this.searchText = "",
      this.results = const []});

  YueYuState copy(
      {bool? isFocused,
      bool? showResult,
      String? searchText,
      List<Word>? results}) {
    return YueYuState(
        isFocused: isFocused ?? this.isFocused,
        showResult: showResult ?? this.showResult,
        searchText: searchText ?? this.searchText,
        results: results ?? this.results);
  }
}
