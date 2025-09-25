import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('ar');
  bool _isArabic = true;

  Locale get currentLocale => _currentLocale;
  bool get isArabic => _isArabic;
  
  String get languageCode => _currentLocale.languageCode;
  TextDirection get textDirection => _isArabic ? TextDirection.rtl : TextDirection.ltr;

  void toggleLanguage() {
    _isArabic = !_isArabic;
    _currentLocale = _isArabic ? const Locale('ar') : const Locale('en');
    notifyListeners();
  }

  void setLanguage(String languageCode) {
    _isArabic = languageCode == 'ar';
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }
}