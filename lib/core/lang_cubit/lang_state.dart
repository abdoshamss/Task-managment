part of 'lang_cubit.dart';

abstract class GeneralState {}

class GeneralInitial extends GeneralState {}

class GeneralChangeLocale extends GeneralState {
  final String locale;
  GeneralChangeLocale({required this.locale});
}
