import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssigtant {
  static Future<dynamic> getRequest(String url) async {
   // String url;
    http.Response response = await http.get(null);
        //.get(url);
        //.get(url);

    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);
        return decodeData;
      } else {
        return " Failed";
      }
    } catch (e) {
      print(e.toString());
      return "Failed";
    }
  }
}
