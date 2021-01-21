import 'dart:io';

class ApiConfig {
  // static String apiUrl = "http://a7f7c1f040de.eu.ngrok.io";
  static String apiUrl =
      Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://127.0.0.1:8080';

  // static const String API_URL = 'http://10.0.2.2:8000';
}
