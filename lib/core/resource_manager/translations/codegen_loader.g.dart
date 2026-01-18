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
    StringManager.addToCart: 'أضف إلى السلة',
    StringManager.back: 'الرجوع',
    StringManager.yourCart: 'سلتك',
    StringManager.cartEmpty: 'سلتك فارغة',
    StringManager.extras: 'الإضافات',
    StringManager.enterCouponHint: 'أدخل كوبونك ...',
    StringManager.apply: 'تطبيق',
    StringManager.paymentDetails: 'تفاصيل الدفع',
    StringManager.totalPrice: 'السعر الإجمالي',
    StringManager.vat: 'ضريبة القيمة المضافة',
    StringManager.totalPayment: 'إجمالي الدفع',
    StringManager.proceedToCheckout: 'المتابعة للدفع',
    StringManager.currencyEgp: 'ج.م',
    StringManager.item: 'عنصر',
    StringManager.noProductsFound: 'لا توجد منتجات حالياً',
    StringManager.home: 'الرئيسية',
    StringManager.menu: 'القائمة',
    StringManager.offers: 'العروض',
    StringManager.account: 'الحساب',
    StringManager.settings: 'الإعدادات',
    StringManager.language: 'اللغة',
    StringManager.selectLanguage: 'اختر اللغة',
    StringManager.english: 'الإنجليزية',
    StringManager.arabic: 'العربية',
    StringManager.productDetails: 'تفاصيل المنتج',
    StringManager.addon: 'إضافة',
    StringManager.option: 'خيار',
    StringManager.requiredIndicator: ' *',
    StringManager.category: 'الفئة',
    StringManager.noDescriptionAvailable: 'لا يوجد وصف متاح.',
    StringManager.zero: '0',
    StringManager.genericError: 'حدث خطأ ما',
    StringManager.unexpectedError: 'حدث خطأ',
    StringManager.notFoundError: 'تعذر العثور على المورد المطلوب.',
    StringManager.serverError: 'عذراً! حدث خطأ من جانبنا.',
    StringManager.networkError:
        'يرجى التحقق من اتصال الإنترنت والمحاولة مرة أخرى.',
    StringManager.unknownValue: 'غير معروف',
    StringManager.retry: 'إعادة المحاولة',
  };

  static const Map<String, dynamic> en = {
  
  };

  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": ar,
    "en": en,
  };
}
