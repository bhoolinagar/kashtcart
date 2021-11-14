import 'package:flutter/cupertino.dart';

class LangaugesChangeProvider with ChangeNotifier {
  Locale _currentLocale = new Locale("en");
   Locale get currentLocale => _currentLocale;
  void changeLocale(String _locale) {
    this._currentLocale = new Locale(_locale);

    notifyListeners();
  }


}
