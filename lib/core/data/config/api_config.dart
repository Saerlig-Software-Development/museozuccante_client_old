import 'dart:io';

class ApiConfig {
  // static String apiUrl = "http://f53340bfa98d.ngrok.io";
  static String apiUrl =
      Platform.isAndroid ? '10.0.2.2:8000' : 'http://127.0.0.1:8000';

  // static const String API_URL = 'http://10.0.2.2:8000';
}
