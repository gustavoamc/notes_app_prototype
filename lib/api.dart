import 'dart:io';

import 'package:flutter/foundation.dart';

class Api {
  static String baseUrl() {
    var url = kReleaseMode
      ? "https://placeholder.azurewebsites.net/api"
      : Platform.isAndroid
        ? "10.0.2.2:5055"
        : "localhost:5055";

    return url;
  }

  static bool isSuccessful(int code){
    if (code >= 200 && code <= 299){
      return true;
    }
    return false;
  }
}
