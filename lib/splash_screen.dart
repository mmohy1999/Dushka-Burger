import 'dart:io';

import 'package:dushka_burger/core/helper/guest_id_manager.dart';
import 'package:dushka_burger/core/resource_manager/app_images.dart';
import 'package:dushka_burger/core/resource_manager/routes_manager.dart';
import 'package:dushka_burger/core/services/logger_service.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _initGuestId();
  }

  Future<void> _initGuestId() async {
    try {
      await GuestIdManager.ensureGuestId();
    } catch (e) {
      LoggerService.logError('Failed to ensure guest_id in splash: $e');
    }
  }

  void _navigateToHome(Duration delay) {
    if (_hasNavigated) {
      return;
    }
    _hasNavigated = true;
    Future.delayed(delay, () {
      Future.delayed(const Duration(microseconds: 200), () {
        if (!mounted) {
          return;
        }
        context.pushReplacementNamed(Routes.home);
      });
    });
  }

  Future<bool> _handleWillPop() async {
    if (Navigator.of(context).canPop()) {
      return true;
    }
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Lottie.asset(
              AppImages.splashLogoAnimation,
              fit: BoxFit.contain,
              repeat: false,
              onLoaded: (composition) {
                _navigateToHome(composition.duration);
              },
            ),
          ),
        ),
      ),
    );
  }
}
