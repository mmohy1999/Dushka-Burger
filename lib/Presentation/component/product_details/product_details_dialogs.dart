import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showBlockingAnimation(BuildContext context, String assetPath) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (dialogContext) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Lottie.asset(
            assetPath,
            width: context.width * 0.6,
            repeat: true,
          ),
        ),
      );
    },
  );
}

Future<void> showSuccessAnimation(BuildContext context, String assetPath) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (dialogContext) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Lottie.asset(
            assetPath,
            width: context.width * 0.6,
            repeat: false,
            onLoaded: (composition) {
              Future.delayed(composition.duration, () {
                final rootNavigator =
                    Navigator.of(dialogContext, rootNavigator: true);
                if (!rootNavigator.canPop()) {
                  return;
                }
                rootNavigator.pop();
              });
            },
          ),
        ),
      );
    },
  );
}
