
import 'package:dushka_burger/core/caching/caching_constant.dart';
import 'package:dushka_burger/core/caching/shared_pref_helper.dart';
import 'package:dushka_burger/core/services/logger_service.dart';
import 'package:dio/dio.dart';
import 'package:dushka_burger/core/services/service_locator.dart';

import '../networking/api_constants.dart';

class GuestIdManager {
  GuestIdManager._();

  static Future<String?> getSavedGuestId() async {
    final stored = await SharedPrefHelper.getString(CachingConstant.guestId);
    if (stored.isEmpty) {
      return null;
    }
    LoggerService.logInfo('Using saved guest_id: $stored');
    return stored;
  }

  static Future<void> saveGuestId(String id) async {
    await SharedPrefHelper.setData(CachingConstant.guestId, id);
  }

  static Future<void> clearGuestId() async {
    await SharedPrefHelper.removeData(CachingConstant.guestId);
  }

  static Future<String> ensureGuestId() async {
    final saved = await getSavedGuestId();
    if (saved != null) {
      return saved;
    }
    final fetched = await _fetchGuestId();
    if (fetched != null) {
      await saveGuestId(fetched);
      return fetched;
    }
    throw Exception('Invalid guest_id response');
  }

  static Future<String> refreshGuestId() async {
    final fetched = await _fetchGuestId();
    if (fetched != null) {
      await saveGuestId(fetched);
      return fetched;
    }
    throw Exception('Invalid guest_id response');
  }

  static Future<String?> _fetchGuestId() async {
    try {
      final Dio dio = getIt<Dio>();
      final response = await dio.get(
        ApiConstants.guestIdPath,
      );
      final data = response.data;

      String? guestId;
      guestId = data['guest_id']?.toString();
      return guestId;
    } catch (e) {
      LoggerService.logError('Failed to fetch guest_id: $e');
      return null;
    }
  }

  static bool isGuestAuthError(DioException err) {
    final status = err.response?.statusCode;
    if (status != 401 && status != 403) {
      return false;
    }

    final data = err.response?.data;
    if (data is Map<String, dynamic>) {
      final code = data['code']?.toString().toLowerCase();
      final message = data['message']?.toString().toLowerCase();
      if (code != null && code.contains('guest')) {
        return true;
      }
      if (message != null && message.contains('guest')) {
        return true;
      }
      if (message != null && message.contains('auth')) {
        return true;
      }
    } else if (data is String) {
      final lower = data.toLowerCase();
      if (lower.contains('guest') || lower.contains('auth')) {
        return true;
      }
    }

    return true;
  }
}
