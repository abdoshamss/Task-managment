import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data_source/hive_service.dart';
import '../../../../../core/utils/general_constants.dart';
import '../../../../tasks/screens/layout_screen.dart';
import '../../../cubit/splash_cubit.dart';
import '../../../cubit/splash_states.dart';
import '../../../on_boarding/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
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
                child: Image.asset(
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
