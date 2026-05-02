import 'package:flutter_bloc/flutter_bloc.dart';

import '../localization/localization_helper.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(GeneralInitial());
  static GeneralCubit get(context) => BlocProvider.of(context);

  void changeLocale(String localeName) {
    if (LocalizationHelper.currentLocalName == localeName) return;

    LocalizationHelper.setLocale(localeName);
    emit(GeneralChangeLocale(locale: LocalizationHelper.currentLocalName));
  }
}
