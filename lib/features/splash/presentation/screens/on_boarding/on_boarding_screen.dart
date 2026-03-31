import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mangment/features/auth/screens/login_screen.dart';

import '../../../../../core/app_strings/app_strings.dart';
import '../../../../../core/extensions/all_extensions.dart';
import '../../../../../core/utils/extentions.dart';
import '../../../../../shared/widgets/button_widget.dart';
import '../../../cubit/splash_cubit.dart';
import '../../../cubit/splash_states.dart';
import 'widgets/dots.dart';
import 'widgets/page_view_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashCubit()..controller = PageController(initialPage: 0),
      child: BlocConsumer<SplashCubit, SplashStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SplashCubit cubit = SplashCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: TextButtonWidget(
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      text: AppStrings.skip,
                      fontweight: FontWeight.w400,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                  32.ph,
                  const PageViewWidget(),
                  ButtonWidget(
                    onTap: () {
                      if (cubit.sliderIndex == 2) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false,
                        );
                      } else {
                        cubit.controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceInOut,
                        );
                      }
                    },
                    title: cubit.sliderIndex == 2
                        ? AppStrings.startNow
                        : AppStrings.next,
                    buttonColor: context.primaryColor,
                  ),
                  16.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      cubit.onboardingModel.length,
                      (int index) => DotsWidget(index: index),
                    ),
                  ),
                  16.ph,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
