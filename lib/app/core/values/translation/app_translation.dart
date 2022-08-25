import 'dart:ui';

import 'package:get/get_navigation/src/root/internacionalization.dart';

import '../../utils/app_storage.dart';
import '../app_strings.dart';
import 'languages/ar_sy.dart';
import 'languages/en_us.dart';

class AppTranslation extends Translations{

  static const arabicLocale = Locale(AppString.arCode,AppString.syCode);
  static const englishLocale = Locale(AppString.enCode,AppString.usCode);

  static Locale get currentLocale {
    final String storageLocale = AppStorage().read(AppStorage.locale) ?? arabicLocale.toLanguageTag();
    return Locale.fromSubtags(languageCode: storageLocale.split("-").first,countryCode: storageLocale.split("-").last);
  }
  static bool get isArabic => currentLocale == arabicLocale;

  static saveLocale(Locale locale){
    AppStorage().write(AppStorage.locale, locale.toLanguageTag());
  }

  @override
  Map<String, Map<String, String>> get keys => {
    "${AppString.arCode}_${AppString.syCode}": arSY,
    "${AppString.enCode}_${AppString.usCode}": enUS
  };

}