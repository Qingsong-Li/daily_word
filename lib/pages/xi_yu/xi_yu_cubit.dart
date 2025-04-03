import 'package:bloc/bloc.dart';
import 'package:dailyword/datas/word.dart';
import 'package:dailyword/pages/xi_yu/xi_yu_state.dart';
import 'package:dailyword/tools/data_base_helper.dart';

class XiYuCubit extends Cubit<XiYuState> {
  XiYuCubit() : super(XiYuState(word: DEFAULTWORD));
  final DatabaseHelper dbHelper = DatabaseHelper();

  void initWord(){
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
}
