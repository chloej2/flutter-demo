import 'package:http/http.dart' as http;
import 'dart:convert';

// class UserApi {

// static Future getUsers() {
//   print('heeele');
//   var response =
//       http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));
//   print(json.decode(response.body));
//   return response;
// }

// }
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
