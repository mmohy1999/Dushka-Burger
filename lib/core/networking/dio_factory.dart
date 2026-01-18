
import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constants.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();

      dio!
        ..options.baseUrl = ApiConstants.apiBaseUrl
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..interceptors.addAll([
          PrettyDioLogger(requestBody: true, requestHeader: true, error: true),
          // Add GuestIdInterceptor by default
        ]);

      addDioHeaders();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeaders() async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': ApiConstants.basicAuthHeader,
    };
    dio?.options.validateStatus = (status) {
      return status != null && status < 400;
    };
  }
}
