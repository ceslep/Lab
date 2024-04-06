// archivo: url_provider.dart

import 'package:flutter/foundation.dart';

class UrlProvider with ChangeNotifier {
  String _url = 'https://app.iedeoccidente.com/lab/';

  String get url => _url;

  void setUrl(String url) {
    _url = url;
    notifyListeners();
  }
}
