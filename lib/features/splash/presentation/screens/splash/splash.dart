import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data_source/hive_service.dart';
import '../../../../../core/utils/general_constants.dart';
import '../../../../../shared/widgets/default_image_widget.dart';
import '../../../../tasks/screens/layout_screen.dart';
import '../../../cubit/splash_cubit.dart';
import '../../../cubit/splash_states.dart';
import '../../../on_boarding/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _navigateToNext();
  }

  void _navigateToNext() {
    Future.delayed(const Duration(milliseconds: 2500), () async {
      if (mounted) {
        final userData = await HiveService.getRaw(
          boxName: GeneralConstants.appBoxName,
          key: GeneralConstants.userKey,
        );

        if (userData != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskFlowLayoutScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<SplashCubit, SplashStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Center(
              child: ZoomIn(
                duration: const Duration(milliseconds: 2000),
                child: const DefaultImageWidget(
                  "assets/images/img1.png",
                  width: double.infinity,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
