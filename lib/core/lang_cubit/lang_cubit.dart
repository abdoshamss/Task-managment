import 'package:flutter_bloc/flutter_bloc.dart';

import '../localization/localization_helper.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(LangInitial());
  static LangCubit get(context) => BlocProvider.of(context);

  void changeLocale(String localeName) {
    if (LocalizationHelper.currentLocalName == localeName) return;

    LocalizationHelper.setLocale(localeName);
    emit(LangChangeLocale(locale: LocalizationHelper.currentLocalName));
  }
}
