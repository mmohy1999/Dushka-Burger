import 'package:flutter/material.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';

enum ErrorType { server, notFound, network }

class ErrorScreen extends StatelessWidget {
  final ErrorType errorType;
  final String? message;
  final VoidCallback? onRetry;

  const ErrorScreen({
    super.key,
    required this.errorType,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final resolvedMessage = message?.isNotEmpty == true
        ? message!
        : _getDefaultMessage();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getTitle(),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.01),
            Text(
              resolvedMessage,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: height * 0.02),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(StringManager.retry.tr()),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    switch (errorType) {
      case ErrorType.server:
        return StringManager.serverError.tr();
      case ErrorType.notFound:
        return StringManager.notFoundError.tr();
      case ErrorType.network:
        return StringManager.networkError.tr();
    }
  }

  String _getDefaultMessage() {
    switch (errorType) {
      case ErrorType.server:
        return StringManager.serverError.tr();
      case ErrorType.notFound:
        return StringManager.notFoundError.tr();
      case ErrorType.network:
        return StringManager.networkError.tr();
    }
  }
}
