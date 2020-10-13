import 'dart:io';

class ApiConfig {
  // static String apiUrl = "http://1f51ed24816a.ngrok.io";
  static String apiUrl =
      Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://127.0.0.1:8080';

  // static const String API_URL = 'http://10.0.2.2:8000';
}
