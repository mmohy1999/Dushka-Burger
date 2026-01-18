import 'package:dushka_burger/core/resource_manager/app_images.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MenuEmptyState extends StatelessWidget {
  const MenuEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.brownColor,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Lottie.asset(
            AppImages.emptyAnimation,
            fit: BoxFit.contain,
            repeat: true,
          ),
        ),
      ),
    );
  }
}
