import 'package:dushka_burger/core/resource_manager/app_images.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MenuSectionEmpty extends StatefulWidget {
  const MenuSectionEmpty({super.key});

  @override
  State<MenuSectionEmpty> createState() => _MenuSectionEmptyState();
}

class _MenuSectionEmptyState extends State<MenuSectionEmpty>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _hasPlayed = true;
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = context.width;
    final height = context.height;
    final animationSize = width * 0.45;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: animationSize,
              height: animationSize,
              decoration: const BoxDecoration(
                color: Color(0xFFF1E6D4),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: animationSize,
                height: animationSize,
                child: Lottie.asset(
                  AppImages.emptyAnimation,
                  controller: _controller,
                  fit: BoxFit.contain,
                  repeat: false,
                  onLoaded: (composition) {
                    _controller.duration = composition.duration;
                    if (_hasPlayed) {
                      _controller.value = 1.0;
                    } else {
                      _controller.forward();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            Text(
              StringManager.noProductsFound.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.037,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
