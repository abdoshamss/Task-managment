import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../on_boarding/onboarding_model.dart';
import 'splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);
  List<OnBoardingModel> get onboardingModel => [
    OnBoardingModel(
      imageUrl: "assets/images/img1.png",
      title: "title",
      subTitle: "subtitle",
    ),
    OnBoardingModel(
      imageUrl: "assets/images/img2.png",
      title: "title",
      subTitle: "subtitle",
    ),
    OnBoardingModel(
      imageUrl: "assets/images/img3.jpg",
      title: "title",
      subTitle: "subtitle",
    ),
  ];
  int sliderIndex = 0;
  late PageController controller;
  void updateSliderIndex(int index) {
    sliderIndex = index;
    emit(ChangeIntroState());
  }
}
