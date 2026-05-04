part of 'lang_cubit.dart';

abstract class LangState {}

class LangInitial extends LangState {}

class LangChangeLocale extends LangState {
  final String locale;
  LangChangeLocale({required this.locale});
}
