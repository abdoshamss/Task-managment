import 'package:flutter/material.dart';

/// Full-screen or centered loading indicator.
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.fullScreen = false});

  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    final child = const Center(child: CircularProgressIndicator());
    if (fullScreen) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return child;
  }
}
