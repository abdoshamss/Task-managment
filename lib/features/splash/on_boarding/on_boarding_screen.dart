import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mangment/features/auth/screens/login_screen.dart';

import '../../../../../shared/widgets/button_widget.dart';

import '../cubit/splash_cubit.dart';
import '../cubit/splash_states.dart';
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
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 64),
                  const PageViewWidget(),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: List.generate(
                          cubit.onboardingModel.length,
                          (int index) => DotsWidget(index: index),
                        ),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 600),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ButtonWidget(
                        onTap: () {
                          if (cubit.sliderIndex ==
                              cubit.onboardingModel.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          } else {
                            cubit.controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        title:
                            cubit.sliderIndex ==
                                cubit.onboardingModel.length - 1
                            ? "Start Now"
                            : "Next",
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
