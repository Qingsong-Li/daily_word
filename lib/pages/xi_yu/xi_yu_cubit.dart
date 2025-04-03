import 'package:bloc/bloc.dart';
import 'package:dailyword/datas/word.dart';
import 'package:dailyword/pages/xi_yu/xi_yu_state.dart';

class XiYuCubit extends Cubit<XiYuState> {
  XiYuCubit() : super(XiYuState(word: DEFAULTWORD));
}
