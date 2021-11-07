import 'package:http/http.dart' as http;

class UserApi {
  static Future getUsers() async {
    final response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load post');
    }
    return response;
  }
}
