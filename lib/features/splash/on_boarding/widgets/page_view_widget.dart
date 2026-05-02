import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/light_theme.dart';
import '../../cubit/splash_cubit.dart';
import '../../cubit/splash_states.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = SplashCubit.get(context);
        return Expanded(
          child: PageView.builder(
            itemCount: cubit.onboardingModel.length,
            controller: cubit.controller,
            onPageChanged: (index) {
              cubit.updateSliderIndex(index);
            },
            itemBuilder: (context, index) {
              final item = cubit.onboardingModel[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: FadeInLeft(
                      child: Image.asset(item.imageUrl, width: 400),
                    ),
                  ),

                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          child: Text(
                            item.title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 36,
                              color: LightThemeColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 200),
                          child: Text(
                            textAlign: TextAlign.start,

                            item.subTitle,
                            style: TextStyle(
                              fontSize: 20,
                              color: const Color(0xff7C7C7C),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index == 0)
                    SizedBox(height: 32)
                  else
                    SizedBox(height: 16),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
