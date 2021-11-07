import 'package:http/http.dart' as http;

class UserImageApi {
  static Future getUserImages(int userId) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos?albumId=$userId'),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to get album.');
    }
  }
}
