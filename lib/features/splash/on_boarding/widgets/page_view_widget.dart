import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/widgets/customtext.dart';

import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/default_image_widget.dart';
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
                    child: FadeInLeft(child: DefaultImageWidget(item.imageUrl)),
                  ),

                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          item.title,
                          align: TextAlign.start,
                          fontSize: 36,
                          color: LightThemeColors.primary,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: 16),
                        CustomText(
                          item.subTitle,
                          fontSize: 20,
                          align: TextAlign.start,
                          color: const Color(0xff7C7C7C),
                          weight: FontWeight.w400,
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
