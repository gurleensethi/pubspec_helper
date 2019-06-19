import 'package:http/http.dart' as http;

class NetworkHelper {
  static const String PUB_URL = "https://pub.dartlang.org/packages/";

  /// Gets the html from <a>pub.dartlang.org</a>.
  static Future<String> fetchPackagePubWebsite(String packageName) async {
    final response = await http.get("$PUB_URL$packageName");
    return response.body;
  }

  /// Gets the html from https://pub.dev/packages?q=?
  static Future<String> fetchSearchPubWebsite(String query) async {
    final response = await http.get("https://pub.dev/packages?q=${query}");
    return response.body;
  }
}
