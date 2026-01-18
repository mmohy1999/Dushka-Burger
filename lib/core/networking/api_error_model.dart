import 'package:dushka_burger/core/resource_manager/string_manager.dart';

class ApiErrorModel {
  final String? message;
  final int? code;
  final Map<String, dynamic>? errors;
  final bool? phoneVerified;
  ApiErrorModel({this.message, this.code, this.errors, this.phoneVerified});

  /// Factory constructor to parse JSON into an `ApiErrorModel` instance
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      message: json['message'] as String?,
      code: json['code'] as int?,
      errors: (json['errors'] ?? json['data']) as Map<String, dynamic>?,
      phoneVerified: json['phone_verified'] as bool?,
    );
  }

  /// Builds a readable message including validation errors when present.
  String get readableMessage {
    final Map<String, dynamic> responseData = {};
    if (message != null) responseData['message'] = message;
    if (code != null) responseData['code'] = code;
    if (errors != null) responseData['errors'] = errors;
    return formatErrorMessages(responseData.isEmpty ? null : responseData);
  }
}

String formatErrorMessages(Map<String, dynamic>? responseData) {
  if (responseData == null) return StringManager.genericError;

  final List<String> messages = [];

  // Add top-level message when available.
  if (responseData.containsKey('message') && responseData['message'] != null) {
    final message = responseData['message'];
    if (message is String && message.isNotEmpty) {
      messages.add(message);
    }
  }

  // If there's an errors object/map, process it
  if (responseData.containsKey('errors')) {
    final errors = responseData['errors'];
    if (errors == null) return StringManager.genericError;

    if (errors is Map) {
      final StringBuffer buffer = StringBuffer();
      errors.forEach((field, messages) {
        if (messages is List) {
          for (var message in messages) {
            buffer.writeln('$field: $message');
          }
        } else {
          buffer.writeln('$field: $messages');
        }
      });
      messages.add(buffer.toString().trim());
    } else if (errors is String) {
      messages.add(errors);
    }
  }

  if (messages.isNotEmpty) return messages.join('\n');

  // Fallback to a generic error message
  return '${StringManager.unexpectedError} (${responseData['code'] ?? StringManager.unknownValue})';
}
