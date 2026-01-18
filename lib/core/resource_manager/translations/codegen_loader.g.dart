import 'dart:ui';

import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';


class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> ar = {
     StringManager.back: 'الرجوع',
    
  };

  static const Map<String, dynamic> en = {
  
  };

  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": ar,
    "en": en,
  };
}
