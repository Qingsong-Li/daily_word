import 'package:bloc/bloc.dart';
import 'package:dailyword/datas/word.dart';
import 'package:dailyword/pages/xi_yu/xi_yu_state.dart';
import 'package:dailyword/tools/data_base_helper.dart';

class XiYuCubit extends Cubit<XiYuState> {
  // 私有构造函数
  XiYuCubit._internal() : super(XiYuState(word: DEFAULTWORD));

  static final XiYuCubit _instance = XiYuCubit._internal();
  factory XiYuCubit() => _instance;

  final DatabaseHelper dbHelper = DatabaseHelper();

  void initWord() {
    _getRandomChengyu();
  }

  void refreshWord() {
    _getRandomChengyu();
  }

  void _getRandomChengyu() async {
    Map<String, dynamic>? randomChengyu = await dbHelper.getRandomChengyu();
    Word randomWord = Word.fromJson(randomChengyu ?? DEFAULTWORD.toJson());
    emit(state.copy(word: randomWord));
  }

  void checkUpdate() async {
    Word newWord = Word.fromJson(
        await dbHelper.getChengyuByName(state.word.name) ??
            DEFAULTWORD.toJson());
    if (newWord.isLike != state.word.isLike) {
      emit(state.copy(word: newWord));
    }
  }
}
