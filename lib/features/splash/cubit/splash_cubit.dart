import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../on_boarding/onboarding_model.dart';
import '../../../core/localization/localization_helper.dart';
import 'splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);
  List<OnBoardingModel> get onboardingModel => [
    OnBoardingModel(
      imageUrl: "assets/images/img1.png",
      title: LocalizationHelper.tr.onboardingTitle1,
      subTitle: LocalizationHelper.tr.onboardingSubtitle1,
    ),
    OnBoardingModel(
      imageUrl: "assets/images/img2.png",
      title: LocalizationHelper.tr.onboardingTitle2,
      subTitle: LocalizationHelper.tr.onboardingSubtitle2,
    ),
    OnBoardingModel(
      imageUrl: "assets/images/img3.jpg",
      title: LocalizationHelper.tr.onboardingTitle3,
      subTitle: LocalizationHelper.tr.onboardingSubtitle3,
    ),
  ];
  int sliderIndex = 0;
  late PageController controller;
  void updateSliderIndex(int index) {
    sliderIndex = index;
    emit(ChangeIntroState());
  }
}
